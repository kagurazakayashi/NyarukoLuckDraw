// 引入压缩需要的插件
const gulp = require('gulp');
const uglify = require('gulp-uglify'); // 压缩js
const css = require('gulp-clean-css'); // 压缩css
const html = require('gulp-htmlmin'); // 压缩html

// 压缩js
gulp.task('js', function () {
    return gulp.src('./src/*.js') // 输入文件
        .pipe(uglify()) // 执行压缩
        .pipe(gulp.dest('dist/js')); // 输出文件
});

// 压缩css
gulp.task('css', async () => {
    await gulp.src(['./src/*.css']) // 输入文件
        .pipe(css()) // 执行压缩
        .pipe(gulp.dest('./dist/')); // 输出文件
});

// 压缩html
gulp.task('html', async () => {
    await gulp.src(['./src/*.html','./templates/*.html']) // 输入文件
        .pipe(html({ collapseWhitespace: true, removeComments: true })) // 删除空格和注释
        .pipe(gulp.dest('./dist/')); // 输出文件
});
