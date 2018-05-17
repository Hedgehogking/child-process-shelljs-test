const fs = require('fs');
const dirPath = process.argv[2];
const cutLine = 1050;

const getFileFromDir = async function (dir) {
  const arr = [];
  const dirs = fs.readdirSync(dir);
  for (let i = 0; i < dirs.length; i++) {
    const filename = dirs[i];
    const tmpStat = fs.statSync(`${dir}/${filename}`);
    let tmpArr = [];
    if (tmpStat.isFile() && !filename.match(/.*\.(jpg|jpeg|png|git|webp|ico|eot|woff|ttf|svg)/)) {
      tmpArr.push(`${dir}/${filename}`);
    } else if (tmpStat.isDirectory() && !filename.match(/^\./) && !['dist', 'node_modules'].includes(filename)) {
      tmpArr = await getFileFromDir(`${dir}/${filename}`);
    }
    arr.push(...tmpArr);
  }
  return arr;
}


if (!dirPath) {
  console.log(`
  请加文件夹绝对路径
                 ||
                 \\/
  node concat.js ***
  `);
} else if (!fs.existsSync(dirPath)) {
  console.log('not exist');
} else {
  let fileStr = '';
  getFileFromDir(dirPath).then(async res => {
    for (const file of res) {
      fileStr += await fs.readFileSync(file, { encoding: 'utf8' });
    }
    const EOL = fileStr.indexOf('\r\n') > -1 ? '\r\n' : '\n';
    const lineArr = fileStr.split(EOL);
    const tmpLineArr = [...lineArr.slice(0, cutLine), ...lineArr.slice(-cutLine)];
    console.log(tmpLineArr.length);
    const tmpFileStr = tmpLineArr.join(EOL);
    fs.writeFileSync('./code.txt', tmpFileStr, { encoding: 'utf8' });
  }).catch(err => {
    console.error(err);
  });
}
