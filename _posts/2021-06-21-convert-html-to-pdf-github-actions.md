---
published: false
---
## Converting HTML to PDF with Github Actions

I just finished updating my CV, it's built with jekyll using modern-resume-theme. Now it´s time to render it to PDF. A year ago I wrote a GH Action just for that.

So I added it to my workflow:
      - name: html to pdf
        uses: misaelnieto/web_to_pdf_action@master
        with:
          webPageURL: https://www.noenieto.com/resume/
          outputFile: ./path/to/my/resume.pdf
          usePuppeteer: true
          useScreen: true
          pdfOptions: '{"format": "Letter", "margin": {"top": "10mm", "left": "10mm", "right": "10mm", "bottom": "10mm"}}'

Now I want to test it. So I installed act, which depends on Docker and Go to run the workflows.

sudo apt install golang-go

nnieto@Pochitoque:~/misaelnieto$ curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  9641  100  9641    0     0  43822      0 --:--:-- --:--:-- --:--:-- 43822
nektos/act info checking GitHub for latest tag
nektos/act info found version: 0.2.23 for v0.2.23/Linux/x86_64
nektos/act info installed /usr/local/bin/act

Luego, en mi repo de mi cv solo ejecuto act:

![First run of act]({{site.baseurl}}/media/act-first-run.PNG)


