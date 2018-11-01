---
published: false
---
## My deploy script with gulp

I created a landing page and it was already using gulp for some tasks. So I tought: "It would be nice if I can use gulp to push my code to the server. After a couple of searches I found [gulp-ssh](https://www.npmjs.com/package/gulp-ssh). The code is pretty simple:

```js
'use strict'
var fs = require('fs');
var gulp = require('gulp');
var GulpSSH = require('gulp-ssh')

var gulpSSH = new GulpSSH({
  ignoreErrors: false,
  sshConfig: {
    host: 'my.server.com',
    port: 22,
    username: 'fulano',
    privateKey: fs.readFileSync('/home/fulano/.ssh/private_key')
  }
})

gulp.task('deploy', function () {
  return gulp
    .src(['**/*', '!.git*', '!package*', '!README*', '!gulpfile.js', '!./node_modules/**', '!./contact/composer.*'])
    .pipe(gulpSSH.dest('/var/www/mah_landing_page'))
})
```

So, `GulpSSH` has the credentials to access the server. Runing `gulp deploy` will start copying all the files in the project directory to the server to the folder `/var/www/mah_landing_page` in the server.

The `gulp.src()` function takes a list of filenames or directories that will be copied to the destination. It supports globbing, but it took me a few tries before I figured it out. I put the explanation below:

| Glob                  |                                               Meaning                                               |
|-----------------------|:---------------------------------------------------------------------------------------------------:|
| '**/*'                |  Upload everything including subdirectories.                                                        |
|  '!.git*              | Exclude .gitignore and .git/                                                                        |
|  !package*            | Will exclude `package.json` and `package-lock.json`                                                 |
| '!README*'            | Exclude README and README.txt                                                                       |
| '!gulpfile.js'        | Also, don't upload the `gulpfile.js`                                                                |
| '!./node_modules/**'  | Ignore the `node_modules` folder. It's huge!                                                        |
| '!./myapp/composer.*' | I have a small PHP app under the `myapp` folder which uses composer. Don't upload composer's files. |

That's it. Works.

