---
layout: post
title:  "Using Amazon SES with your python applications"
date:   2012-06-18 19:02:10 -0800
categories: English AWS Amazon Email Python Servers Grok Zope
redirect_from: /blog/html/2012/06/18/using_amazon_ses_with_your_python_applications
---

## Intro

One of the nice things about Amazon SES (Simple Email Service) is that they
have a SMTP interface for legacy applications.

To configure a SMTP service you need several parameters. Here's a list of
five things you will need and where to find it:

- **Server hostname or IP address:** You can find this information in the
  amazon console. Amazon SES -> Navigation pane -> SMTP Settings ->
  SMTP server name.

- **Server port:** Amazon's SMTP server listens in three ports: 25, 465 and
  587. But I've struggled enough with this and the only port that will work
  right away is  port **587**.

- Make sure your Python installation supports TLS (Transport Layer Security).

If you haven't created your IAM credentials, do so now. There's a button right
there in the SMTP Settings pane that will help you do so. If you forget your
SMTP password, you will need to delete your SMTP credentials using the AWS IAM
Dashboard. You will use the SMTP username and password provided by the IAM
credentials created in that panel.

Finally, don't forget to verify a couple of email addresses if you haven't got
access to production SES.

## Sending email from a simple script

Here's a script that you can use to test Amazon's SES from your application or
from the command line. Adapt it as you wish.

```python

#!/usr/bin/python
import smtplib

def prompt(prompt):
    return raw_input(prompt).strip()

fromaddr = 'dude@somewhere.com'
toaddrs  = 'w00t@somewherelse.com'
msg = """From: dude@somewhere.com

Hello, this is doge.
"""

print "Message length is " + repr(len(msg))

#Change according to your settings
smtp_server = 'email-smtp.us-east-1.amazonaws.com'
smtp_username = 'AKASDXWXDSAEGA'
smtp_password = 'AgYlkjahdkjhasd0+m13DAraadHeiXFASDFASDjF'
smtp_port = '587'
smtp_do_tls = True

server = smtplib.SMTP(
    host = smtp_server,
    port = smtp_port,
    timeout = 10
)
server.set_debuglevel(10)
server.starttls()
server.ehlo()
server.login(smtp_username, smtp_password)
server.sendmail(fromaddr, toaddrs, msg)
print server.quit()

```

This is the output of the terminal.

```bash
$ python send_email.py

Message length is 44
send: 'ehlo [192.168.1.73]\r\n'
reply: '250-email-smtp.amazonaws.com\r\n'
reply: '250-8BITMIME\r\n'
reply: '250-SIZE 10485760\r\n'
reply: '250-STARTTLS\r\n'
reply: '250-AUTH PLAIN LOGIN\r\n'
reply: '250 Ok\r\n'
reply: retcode (250); Msg: email-smtp.amazonaws.com
8BITMIME
SIZE 10485760
STARTTLS
AUTH PLAIN LOGIN
Ok
send: 'STARTTLS\r\n'
reply: '220 Ready to start TLS\r\n'
reply: retcode (220); Msg: Ready to start TLS
send: 'ehlo [192.168.1.73]\r\n'
reply: '250-email-smtp.amazonaws.com\r\n'
reply: '250-8BITMIME\r\n'
reply: '250-SIZE 10485760\r\n'
reply: '250-STARTTLS\r\n'
reply: '250-AUTH PLAIN LOGIN\r\n'
reply: '250 Ok\r\n'
reply: retcode (250); Msg: email-smtp.amazonaws.com
8BITMIME
SIZE 10485760
STARTTLS
AUTH PLAIN LOGIN
Ok
send: 'AUTH PLAIN FASDF·AFfadsfadsf3452345asdfdSDFASDTW345qasfase435\r\n'
reply: '235 Authentication successful.\r\n'
reply: retcode (235); Msg: Authentication successful.
send: 'mail FROM:<dude@somewhere.com> size=44\r\n'
reply: '250 Ok\r\n'
reply: retcode (250); Msg: Ok
send: 'rcpt TO:<w00t@somewherelse.com>\r\n'
reply: '250 Ok\r\n'
reply: retcode (250); Msg: Ok
send: 'data\r\n'
reply: '354 End data with <CR><LF>.<CR><LF>\r\n'
reply: retcode (354); Msg: End data with <CR><LF>.<CR><LF>
data: (354, 'End data with <CR><LF>.<CR><LF>')
send: 'From: dude@somewhere.com\r\n\r\nHello, this is dog.\r\n.\r\n'
reply: '250 Ok 0000013802d175af-a924148e-f275-4635-994f-181f6aca6135-000000\r\n'
reply: retcode (250); Msg: Ok 0000013802d175af-a924148e-f275-4635-994f-181f6aca6135-000000
data: (250, 'Ok 0000013802d175af-a924148e-f275-4635-994f-181f6aca6135-000000')
send: 'quit\r\n'
reply: '221 Bye\r\n'
reply: retcode (221); Msg: Bye
(221, 'Bye')
```

## Sending email from Grok and Zope Applications

Just use `zope.sendmail <http://pypi.python.org/pypi/zope.sendmail>`_ and the
following ZCML snippet.

```xml

<configure xmlns="http://namespaces.zope.org/zope"
           xmlns:mail="http://namespaces.zope.org/mail">

    <mail:smtpMailer
      name="amazon.ses.smtp"
      hostname="email-smtp.us-east-1.amazonaws.com"
      port="587"
      username="WRDAsfereFASDFASDFBH"
      password="FASsxasdf552fdsa34fadsaFAS4343SDS"
      />

    <mail:queuedDelivery
      name="Mail"
      permission="zope.Public"
      mailer="amazon.ses.smtp"
      queuePath="./mailqueue"
      />
</configure>
```

## Sending email from Django Apps

It's also easy with Django. Just modify ``settings.py``. Example:

```python
EMAIL_HOST = "email-smtp.us-east-1.amazonaws.com"
EMAIL_HOST_USER = "FDSFASDFASJFAFDJSAFSBBCAXA"
EMAIL_HOST_PASSWORD = "FASDFAsdcasdfadsAFdfadsf52soomn3sguu45hk23"
EMAIL_PORT = 587
EMAIL_USE_TLS = True
```

Fin.