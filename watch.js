require('shelljs/global');
const fs = require('fs');
const moment = require('moment');
const uglifyjs = require('uglify-js');
const cssmin = require('cssmin');
fs.watch('./', {
    // 递归，搜索子目录
    recursive: true,
}, (event, filename) => {
    if (event === 'change' && /app\/modules\/.*\.(?:css|js)$/.test(filename) && !/\.min\.(?:css|js)$/.test(filename)) {
        const path = filename.replace(/^(.*)\/(?:css|script)\/(.*)\.(?:css|js)$/, '$1/views/$2.volt');
        const outFileName = filename.replace(/(.*)\.(css|js)/, '$1.min.$2');
        const tmpTime = moment().format('YYYYMMDDHHmmss');
        // --stats可以配置自动添加时间
        let minCode = '/*! build:' + moment().format('YYYY-MM-DD HH:mm:ss') + '*/';
        if (/\.css$/.test(filename)) {
            // 修改css路径时间戳
            sed('-i', /(\.css\?v={{\sVersion\|default\(''\)\s}})[_\d]*/, '$1_' + tmpTime, path);
            // 压缩css
            minCode += cssmin(fs.readFileSync(filename, encoding = 'utf8'));
        } else if (/\.js$/.test(filename)) {
            // 修改js路径时间戳
            sed('-i', /(\.js\?v={{\sVersion\|default\(''\)\s}})[_\d]*/, '$1_' + tmpTime, path);
            // 压缩js
            minCode += uglifyjs.minify(filename).code;
        }
        // 替换被压缩的css|js
        ShellString(minCode).to(outFileName);
        console.log('压缩: ' + filename);
        console.log('修改时间戳: ' + path);
        console.log('执行完成，请确保路径没错！Time: ' + moment().format('YYYY-MM-DD HH:mm:ss'));
    }
});

