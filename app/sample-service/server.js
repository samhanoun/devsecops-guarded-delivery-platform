const http = require('http');
const server = http.createServer((req, res) => {
  if (req.url === '/healthz') return res.end('ok');
  res.end('secure sample service');
});
server.listen(3000);
