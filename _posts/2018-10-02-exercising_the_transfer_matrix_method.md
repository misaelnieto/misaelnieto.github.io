---
published: true
---
## Exercising the transfer matrix method "by pencil"

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


| Layer      | λ (nm) |   n   |     k    | Notes                                                |
|------------|:------:|:-----:|:--------:|------------------------------------------------------|
| 0 (air)    |   600  |  1.0  |    0.0   | [Lei18]                                              |
| 1 (ITO)    |   600  | 2.134 | 8.370E-4 | ITO Sputtered @1.2e20 cm-3 (Lei-18)                  |
| 2 (a-Si-p) |   600  | 3.710 | 8.496E-2 | -type amorphous silicon deposited by PECVD  (Lei-18) |
| 3 (a-Si-n) |   600  | 3.934 | 8.559E-2 | n-type amorphous silicon deposited by PECVD (Lei-18) |
| 4 (Al)     |   600  | 1.200 |   7.260  | [Pal85b]                                             |

_**Table 1** - Refractive indexes for Air, ITO, a-Si and Al_


## Step 2: Compute reflection and transmission at the interface

The reflection on the interface 3 is right in-between layer 2 and 3, so i'll name it $r_{23}$ .It's calculated by the following expression:

$$
x = r_{23} = \frac{ n_3 - n_2 }{n_3 + n_2}\
$$

We need to know how many

## References

- [Lei18] 	M. Leilaeioun, Z.J. Yu, S. Manzoor, K. Fisher, J. Shi and Z. Holman, 'Design of the front transparent conductive oxide layer of silicon heterojunction solar for four-terminal tandem applications', In preparation 2018. 
- [Pal85b] 	E. Palik, Handbook of Optical Constants of Solids Vol I, Academic Press, Orlando, pp. 397–400, 1985.
