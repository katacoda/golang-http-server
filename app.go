package main

import (
  "fmt"
  "net/http"
  "os"
)

var isHealthy bool

func handler(w http.ResponseWriter, r *http.Request) {
  var name, _ = os.Hostname()

  if(isHealthy) {
    fmt.Fprintf(w, "<h1>A healthy request was processed by host: %s</h1>\n", name)
  } else {
    w.WriteHeader(500)
    fmt.Fprintf(w, "<h1>A unhealthy request was processed by host: %s</h1>\n", name)
  }
}

func healthy(w http.ResponseWriter, r *http.Request) {
  isHealthy = true
}

func unhealthy(w http.ResponseWriter, r *http.Request) {
  isHealthy = false
}

func main() {
  fmt.Fprintf(os.Stdout, "Web Server started. Listening on 0.0.0.0:80\n")
  isHealthy = true
  http.HandleFunc("/", handler)
  http.HandleFunc("/healthy", healthy)
  http.HandleFunc("/unhealthy", unhealthy)
  http.ListenAndServe(":80", nil)
}
