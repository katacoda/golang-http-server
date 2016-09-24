package main

import (
  "fmt"
  "net/http"
  "os"
)

func handler(w http.ResponseWriter, r *http.Request) {
  var name, _ = os.Hostname()

  fmt.Fprintf(w, "<h1>App v2 processed this request on host: %s</h1>\n", name)
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintln(w, "ok")
}

func main() {
  fmt.Fprintf(os.Stdout, "Web Server started. Listening on 0.0.0.0:8080\n")
  http.HandleFunc("/", handler)
  http.HandleFunc("/_health", healthHandler)
  http.ListenAndServe(":8080", nil)
}
