Testing Plone-HAProxy-Varnish stack
===================================



.. author:: default
.. categories:: none
.. tags:: none
.. comments::

Description of static tests
---------------------------
Uso ApacheBenchmark, acá los resultados.

Plone in daemon mode
^^^^^^^^^^^^^^^^^^^^

$ ab -n 10000 -c 10 http://127.0.0.1:8004/Plone/spinner.gif

Server Software:        Zope/(Zope
Server Hostname:        127.0.0.1
Server Port:            8004

Document Path:          /Plone/spinner.gif
Document Length:        2037 bytes

Concurrency Level:      10
Time taken for tests:   113.984 seconds
Complete requests:      10000
Failed requests:        0
Write errors:           0
Total transferred:      23550000 bytes
HTML transferred:       20370000 bytes
Requests per second:    87.73 [#/sec] (mean)
Time per request:       113.984 [ms] (mean)
Time per request:       11.398 [ms] (mean, across all concurrent requests)
Transfer rate:          201.77 [Kbytes/sec] received

Ahora este es el benchmark para Varnish


$ ab -n 10000 -c 10 http://127.0.0.1:8101/Plone/spinner.gif
This is ApacheBench, Version 2.3 <$Revision: 1430300 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 1000 requests
Completed 2000 requests
Completed 3000 requests
Completed 4000 requests
Completed 5000 requests
Completed 6000 requests
Completed 7000 requests
Completed 8000 requests
Completed 9000 requests
Completed 10000 requests
Finished 10000 requests


Server Software:        Zope/(Zope
Server Hostname:        127.0.0.1
Server Port:            8101

Document Path:          /Plone/spinner.gif
Document Length:        2037 bytes

Concurrency Level:      10
Time taken for tests:   2.504 seconds
Complete requests:      10000
Failed requests:        0
Write errors:           0
Total transferred:      24129990 bytes
HTML transferred:       20370000 bytes
Requests per second:    3993.62 [#/sec] (mean)
Time per request:       2.504 [ms] (mean)
Time per request:       0.250 [ms] (mean, across all concurrent requests)
Transfer rate:          9410.74 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.4      0       4
Processing:     0    2   7.2      1     226
Waiting:        0    2   7.2      1     225
Total:          0    2   7.3      2     227

Percentage of the requests served within a certain time (ms)
  50%      2
  66%      2
  75%      3
  80%      3
  90%      4
  95%      5
  98%      7
  99%     10
 100%    227 (longest request)
