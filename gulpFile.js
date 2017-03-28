var gulp = require("gulp");
var source = require("vinyl-source-stream");
var buffer = require("vinyl-buffer");
var cp = require("child_process");
var stylus = require("gulp-stylus");
var coffeeify = require("coffeeify");
var browserify = require("browserify");
var concat = require("gulp-concat");
var util = require("gulp-util");


var paths = {
  development: "./development",
  distribution: "./distributionribution",
  mainElm: "./source/Main.elm",
  elm: "./source/**/*.elm",
  css: "./source/**/*.styl",
  js: "./source/*.js"
};


var production = false;


gulp.task("js", function() {
  return browserify("./source/app.js", {
    debug: !production,
    cache: {},
  }).bundle()
    .pipe(source("app.js"))
    .pipe(buffer())
    .pipe(gulp.dest(paths.development));
});

gulp.task("stylus", function() {
  return gulp
    .src([ "./source/Styles/main.styl", paths.css ])
    .pipe(concat("style.styl"))
    .pipe(stylus())
    .pipe(gulp.dest(paths.development));
});


// Uncomment out for automatic formatting
// gulp.task("elm", ["elm-format", "elm-make"]);
gulp.task("elm", ["elm-make"]);



gulp.task("elm-format", function() {
  var formatCmd = "elm-format ./source --yes";
  cp.exec(formatCmd, function(error, stdout) {})
})


gulp.task("elm-make", function () {
 var cmd;

  cmd = "elm-make ";
  cmd += paths.mainElm;
  cmd += " --output ";
  cmd += paths.development + "/elm.js";

  cp.exec(cmd, function(error, stdout) {
    if (error) {
      util.log(util.colors.cyan("Elm"),
        util.colors.red(String(error))
      );
    } 
    var stdout = stdout.slice(0, stdout.length - 1);

    stdout.split("\n").forEach(function(line) {
      util.log(util.colors.cyan("Elm"), line);
    })
  }); 
})

gulp.task("server", function() {
  return require("./server")(2982, util.log);
});


gulp.task("distribution", function() {
  production = true;
  gulp.task("default");

  return gulp
    .src(paths.development + "/**/*")
    .pipe(gulp.dest(paths.distribution));
})


gulp.watch(paths.elm, ["elm"]);
gulp.watch(paths.css, ["stylus"]);
gulp.watch(paths.js, ["js"]);
gulp.watch("development/index.html", ["server"])


gulp.task("default", ["elm", "js", "stylus", "server"]);
