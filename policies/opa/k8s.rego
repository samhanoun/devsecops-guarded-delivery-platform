package main

deny[msg] {
  input.kind == "Deployment"
  c := input.spec.template.spec.containers[_]
  not c.securityContext.runAsNonRoot
  msg := sprintf("container %s must set runAsNonRoot=true", [c.name])
}


deny[msg] {
  input.kind == "Deployment"
  c := input.spec.template.spec.containers[_]
  contains(c.image, ":latest")
  msg := sprintf("container %s uses latest tag", [c.name])
}
