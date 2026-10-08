from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html; charset=utf-8")
        self.end_headers()

        self.wfile.write(
            b"<h1>Ola! Minha aplicacao esta rodando no Kubernetes.</h1>"
        )

server = HTTPServer(("0.0.0.0", 5000), Handler)

print("Servidor iniciado na porta 5000")

server.serve_forever()
