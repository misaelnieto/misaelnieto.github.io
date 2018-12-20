---
published: false
---
## Learning to use jq, the Command-line JSON processor

Today I learned that [jq](https://stedolan.github.io/jq/) exists. It's a json preprocessor for the command line. The following examples 

### Start here

As an example, the first use is to pretty print a JSON output from a program like curl.

```
curl --silent "https://jsonplaceholder.typicode.com/comments?postId=1" | jq
```
![Pretty JSON output from curl and jq]({{site.baseurl}}/media/Screenshot-20181220110520-948x815.png)

In comparison [httpie](https://httpie.org/) has also colored output of json data, but `jq` is a JSON processor, so it does more than pretty-print json data: you can apply filters to the data. For example, on the previous example we get a list of objects I can extract the third object:

```
curl --silent "https://jsonplaceholder.typicode.com/comments?postId=1" | jq .[3]
```
![Filtered output]({{site.baseurl}}/media/gnome-shell-screenshot-J70ZTZ.png)

### Querying complex objects

Now let's consider a more complicated json; for example, a list of images on digitalocean returns only one object with nested arrays on objects.

```curl -X GET --silent "https://api.digitalocean.com/v2/images?per_page=999" -H "Authorization: Bearer $MY_DO_API_KEY" | jq keys``

```json
{
  "images": [<< a big list of objects >>],
  "links": {},
  "meta": {
    "total": 77
  }
}
```

With `jq` we can get all the keys of the main object in a list:

```
curl -X GET --silent "https://api.digitalocean.com/v2/images" -H "Authorization: Bearer $MY_DO_API_KEY" | jq keys
```

```json
[
  "images",
  "links",
  "meta"
]

```

This is how you can get only the `links` and `meta` objects:

```
curl -X GET --silent "https://api.digitalocean.com/v2/images" -H "Authorization: Bearer $MY_DO_API_KEY" | jq '.links , .meta'
```
```json
{}
{
  "total": 77
}
```

Now let's pickup the first element from the `images` array:

```
curl -X GET --silent "https://api.digitalocean.com/v2/images" -H "Authorization: Bearer $MY_DO_API_KEY" | jq '.images[1]'
```
```json

{
  "id": 16376426,
  "name": "Cassandra on 14.04",
  "distribution": "Ubuntu",
  "slug": "cassandra",
  "public": true,
  "regions": [
    "nyc1",
    "sfo1",
    "nyc2",
    "ams2",
    "sgp1",
    "lon1",
    "nyc3",
    "ams3",
    "fra1",
    "tor1",
    "sfo2",
    "blr1"
  ],
  "created_at": "2016-03-21T04:25:45Z",
  "min_disk_size": 30,
  "type": "snapshot",
  "size_gigabytes": 0.59,
  "description": "",
  "tags": [],
  "status": "available",
  "error_message": ""
}
```

I can also get slices of the list of images:

```
 curl -X GET --silent "https://api.digitalocean.com/v2/images" -H "Authorization: Bearer $MY_DO_API_KEY" | jq '.images[3:5]'
 ```
 ```json
[
  {
    "id": 24081356,
    "name": "10.3 x64 zfs",
    "distribution": "FreeBSD",
    "slug": "freebsd-10-3-x64-zfs",
    "public": true,
    "regions": [
      "nyc1",
      "sfo1",
      "nyc2",
      "ams2",
      "sgp1",
      "lon1",
      "nyc3",
      "ams3",
      "fra1",
      "tor1",
      "sfo2",
      "blr1"
    ],
    "created_at": "2017-04-10T23:57:15Z",
    "min_disk_size": 20,
    "type": "snapshot",
    "size_gigabytes": 1,
    "description": "Freebsd freebsd-10-3 x64 20170410 zfs",
    "tags": [],
    "status": "available",
    "error_message": ""
  },
  {
    "id": 24081552,
    "name": "10.3 x64",
    "distribution": "FreeBSD",
    "slug": "freebsd-10-3-x64",
    "public": true,
    "regions": [
      "nyc1",
      "sfo1",
      "nyc2",
      "ams2",
      "sgp1",
      "lon1",
      "nyc3",
      "ams3",
      "fra1",
      "tor1",
      "sfo2",
      "blr1"
    ],
    "created_at": "2017-04-11T00:03:44Z",
    "min_disk_size": 20,
    "type": "snapshot",
    "size_gigabytes": 0.95,
    "description": "10.3 x64 20170412",
    "tags": [],
    "status": "available",
    "error_message": ""
  }
]
```

Now, i only want to know the slug field of every image object:

```
curl -X GET --silent "https://api.digitalocean.com/v2/images" -H "Authorization: Bearer $MY_DO_API_KEY" | jq '.images[3:5][] | .slug'
```
```json
"freebsd-10-3-x64-zfs"
"freebsd-10-3-x64"

```
