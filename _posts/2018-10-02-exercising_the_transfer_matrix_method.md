---
published: true
mathjax: true
---
## Exercising the transfer matrix method

I'm attending a class on Electromagneting Wave Propagation in the Instituto de Ingeniería, UABC Mexicali, with Dr. Carlos Villa Angulo. He kindly allowed me to go to the class altough i'm not currently enrolled as a graduate student. Here in Mexico we say that I'm attending as _"Listener (oyente)"_. I don't know the exact term used in english for this but I know nobody visits my blog, so it doesn't matter anyway.

We are now in the 5th or 6th week of the course and we are now studying the Transfer Matrix Method to understand the propagation of electromagnetic waves (e.g. Light) through different layers of materials with different reflection and absoroption coefficients. There are a lot of applications for this method, and is one used to simulate the absorption of light in a solar cell with multple layers.

Since we are just a few people in the class room (9) the professor assigned a different device for each sudent and everyone must make a presentation and write a detailed report with the calculations made.

## The device

My device has 4 layers: ITO, a-Si-n, a-Si-p and Aluminum. Let's picture that with majestic detail using our latest, state of the art, ASCII 2D diagrams (but using UTF-8, sorry):

```
  ~ ~ ~ Air ~ ~ ~

+-------------------+ <------+  Interface 1
|  ITO (200nm)      | <------------------------+ Layer 1
+-------------------+ <------+  Interface 2
|                   |
|  a-Si-p (300 nm)  | <------------------------+ Layer 2
|                   |
+-------------------+ <------+  Interface 3
|                   |
|  a-Si-n (10 µm)   | <------------------------+ Layer 3
~                   ~
~                   ~
+-------------------+ <------+  Interface 4
|  Al (500 nm)      | <------------------------+ Layer 4
+-------------------+

           * Important: not to scale
```

Final note (yet important): the professor assigned us to analyze only one layer, which in my case is the layer number three, only on the 600nm wavelenght! So let's get our hands dirty, will ya?

## Step 1: Get the coefficients for the materials

The first step is to calculate the coefficients of reflection and diffraction. Going top to bottom, the first interface is number 3, between a-Si-p (amorphous silicon doped p) and a-Si-n (amorphous silicon doped n).

The guys at PV Lighthouse are kind enough to publish refractive index tables for a wide variety of materials, including Silicon. They even include the citatino of their references!!. So, for my own convenience, I'm going to include a small table with the real and imaginary part of all the materials needed to build the device avobe @600 nm.


| Layer        | λ (nm) |   n   |     k    | Notes                                                |
|--------------|:------:|:-----:|:--------:|------------------------------------------------------|
| 0 (air)      |   600  |  1.0  |    0.0   | [Lei18]                                              |
| 1 (ITO)      |   600  | 2.134 | 8.370E-4 | ITO Sputtered @1.2e20 cm-3 (Lei-18)                  |
| 2 (a-Si-p)   |   600  | 3.710 | 8.496E-2 | -type amorphous silicon deposited by PECVD  (Lei-18) |
| 3 (a-Si-n)   |   600  | 3.934 | 8.559E-2 | n-type amorphous silicon deposited by PECVD (Lei-18) |
| 4 (Al)       |   600  | 1.200 |   7.260  | [Pal85b]                                             |

_**Table 1** - Refractive indexes for Air, ITO, a-Si and Al_


## Step 2: Compute reflection and transmission at the interface

Look at the following schema:

```
   a-Si-p          a-Si-n
       +---+----------------------------+
       |   |                            |
       |   +----- Transmission --->     |
       |   |                            |
+---------->                            |
       |   |                            |
       |   <------ Reflection ----+     |
       |   |                            |
       |   |                            |
       +--------------------------------+
 Layer 2   |           Layer 3
           |
           +----> Interface 3
```

The reflection on the interface 3 is right in-between layer 2 and 3, so i'll name it \\(r_{23}\\). It's calculated by the following expression:

$$ r_{23} = \frac{ n_3 - n_2 }{n_3 + n_2}\ $$

... so ... :

$$ 
r_{23} = \frac{ 3.934 + i8.559x10^{-2}  -  3.710 - i8.496x10^{-2} }{ 3.934 + i8.559x10^{-2}  +  3.710 + i8.496x10^{-2} }\
       = \frac{ 0.224 + i6.3x10^{-4}}{ 7.644 + i0.17055 }\
       = 0.2929 + i5.71x10^{-4}
$$

The transmission of the interface 3 is, conversely:

$$ t_{23} = 1 + r{23} = 1 + \frac{ n_3 - n_2 }{n_3 + n_2}\ = 1.2929 + i5.7x10^{-4}$$

Working with complex numbers by using paper and pencil (and maybe a calculator) is no fun, and prone to errors. So I wrote these python functions to compute the transmission and reflection coefficients:

```python
def transmission(n1, n2):
    """
    Compute the transmission coefficient between two materials.

    Both n1, n2 are the complex refractive indexes for both materials.
    """
    return 1 + (n2 - n1) / (n2 + n1)


def reflection(n1, n2):
    """
    Compute the transmission coefficient between two materials.

    Both n1, n2 are the complex refractive indexes for both materials.
    """
    return (n2 - n1) / (n2 + n1)
 ```

Let's take this functions and test them with our own values:

```python
>>> n2 = 3.710 + 0.08496j
>>> n3 = 3.934 + 0.08559j
>>> reflection(n2, n3)
(0.029291286729338666-0.0005711183871910915j)
>>> tmm.transmission(n2, n3)
(1.0292912867293387-0.0005711183871910915j)
```
... it works, good.

## Interface matrix

The interface matrix describes the effect on the incident field (e.g. light @ 600nm) when it impacts interface 3. The interface matrix //(I_{23}//), is defined as follows:

$$
I_{23} =  \frac{1}{t_{23}}   \begin{bmatrix} 1 & r_{23} \\ r_{23} & 1 \end{bmatrix} 
$$

After substitution, //(I_{23}//) becomes this:

$$
I_{23} =  \frac{1}{1.2929 + i5.7x10^{-4}}   \begin{bmatrix} 1 & 0.2929 + i5.71x10^{-4} \\ 0.2929 + i5.71x10^{-4} & 1 \end{bmatrix} 
$$

Which is becoming a bit startling ...

![For mere mortals ...]({{site.baseurl}}/media/abandon-thread_fb_3029909.jpg)

... for mere mortals. Yet we are still here, aren't we?

Python does not support matrices out of the box, but with a little help of [numpy](https://docs.scipy.org/doc/numpy/) we can solve this matrix in no time:

```python
import numpy

>>> n2 = 3.710 + 0.08496j
>>> n3 = 3.934 + 0.08559j
>>> r_23 = reflection(n2, n3)
>>> t_23 = transmission(n2, n3)

>>> 1/t_23
(0.9715419774918925+0.0005390752787160436j)

>>> print(numpy.array([[1, r_23], [r_23, 1]]))
[[1.        +0.j         0.02929129-0.00057112j]
 [0.02929129-0.00057112j 1.        +0.j        ]]

>>> I_23 = 1/t_23 * numpy.array([[1, r_23], [r_23, 1]])

[[0.97154198+0.00053908j 0.02845802-0.00053908j]
 [0.02845802-0.00053908j 0.97154198+0.00053908j]]

>>> print(I_23)
[[0.97154198+0.00053908j 0.02845802-0.00053908j]
 [0.02845802-0.00053908j 0.97154198+0.00053908j]]
```

## Propagation matrix

The propagation matrix describe the effect on the incident field when it propagates through the layer. To find this matrix we need to calculate the propagation coefficient (phase differential?) for the silicon layer 3 at //( \lambda = 600 nm //) so we can use the phasorial notation:

$$
 \beta_3 = \frac {2 \pi d_z}{\lambda} n_3 cos \phi_3 
$$

Where:
- //( n_3 //) is the real par of the complex index of diffraction of layer 3 (n=3.934).
- //( \phi_3 //) is the angle of incidence of the light
- //( d_z //) is the height of layer 3 , which in my case is 10 µm.

So  //(\beta_3//) becomes:

$$
\beta_3 = \frac {2 \pi \cdot d_z}{\lambda} n_3 \cdot cos(\phi_3 )
        = \frac {2 \pi \cdot 200 nm)}{600 nm} \cdot (3.934) \cdot cos(0)
        = \frac {2 *3.1416 * 200 nm  * 3.934}{600 nm}
\\
\beta_3 = 8.2393696
$$

Now we can assemble the propagation matrix:

$$
P =  \begin{bmatrix} e^{-j \beta_3 \cdot z} & 0 \\ 0 & e^{-j \beta_3 \cdot z} \end{bmatrix} 
  =  \begin{bmatrix} 0.9999 - i8.234x10^{-06} & 0 \\ 0 & 0.9999 - i8.234x10^{-06}} \end{bmatrix} 
$$

Resulting as follows
## References

- [Lei18] 	M. Leilaeioun, Z.J. Yu, S. Manzoor, K. Fisher, J. Shi and Z. Holman, 'Design of the front transparent conductive oxide layer of silicon heterojunction solar for four-terminal tandem applications', In preparation 2018. 
- [Pal85b] 	E. Palik, Handbook of Optical Constants of Solids Vol I, Academic Press, Orlando, pp. 397–400, 1985.
