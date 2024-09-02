const express = require("express");
const app = express();
const { exec } = require("child_process");
const os = require("os");
const { createProxyMiddleware } = require("http-proxy-middleware");

const port = process.env.PORT || 3000;

// 读取 TMP_ARGO 变量并根据其值设置 vmms 和 vmmport
const tmpArgo = process.env.TMP_ARGO;
let vmms, vmmport;

if (tmpArgo === 'vms') {
  vmms = process.env.MPATH || 'vms';
  vmmport = process.env.VM_PORT || '8001';  // 默认值改为 8001
} else if (tmpArgo === 'vls') {
  vmms = process.env.VPATH || 'vls';
  vmmport = process.env.VL_PORT || '8002';  // 保持 8002 作为默认值
} else {
  // 默认值，如果 TMP_ARGO 既不是 'vms' 也不是 'vls'
  vmms = 'vls';
  vmmport = '8002';
}

console.log(`==============================`);
console.log(``);
console.log("     /stas 查看进程");
console.log("     /listen 查看端口");
console.log(``);
console.log(`==============================`);

// 网页信息
app.get("/", function (req, res) {
  res.send("hello world");
});

// 获取系统进程表
app.get("/stas", function (req, res) {
  let cmdStr = "ps aux | sed 's@--token.*@--token ${TOK}@g;s@-s.*@-s ${NEZHA_SERVER}@g'";
  exec(cmdStr, function (err, stdout, stderr) {
    if (err) {
      res.type("html").send("<pre>命令行执行错误：\n" + err + "</pre>");
    } else {
      res.type("html").send("<pre>获取系统进程表：\n" + stdout + "</pre>");
    }
  });
});

// 获取系统版本、内存信息
app.get("/info", function (req, res) {
  let cmdStr = "cat /etc/os-release";
  exec(cmdStr, function (err, stdout, stderr) {
    if (err) {
      res.send("命令行执行错误：" + err);
    } else {
      res.send(
        "命令行执行结果：\n" +
        "Linux系统：" +
        stdout +
        "\n内存：" +
        os.totalmem() / 1000 / 1000 +
        "MB"
      );
    }
  });
});

// 获取系统监听端口
app.get("/listen", function (req, res) {
  let cmdStr = "netstat -nltp";
  exec(cmdStr, function (err, stdout, stderr) {
    if (err) {
      res.type("html").send("<pre>命令行执行错误：\n" + err + "</pre>");
    } else {
      res.type("html").send("<pre>获取系统监听端口：\n" + stdout + "</pre>");
    }
  });
});

app.use(
  `/${vmms}`,
  createProxyMiddleware({
    changeOrigin: true,
    onProxyReq: function (proxyReq, req, res) { },
    pathRewrite: {
      [`^/${vmms}`]: `/${vmms}`,
    },
    target: `http://127.0.0.1:${vmmport}/`,
    ws: true,
  })
);

app.listen(port, () => {
  console.log(`应用正在监听端口 ${port}！\n==============================`);
});
