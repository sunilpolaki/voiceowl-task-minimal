# voiceowl-task-minimal

# DevSecOps CI/CD Project – JPetStore Pet Shop Application

A complete **DevSecOps pipeline** implementation for the **Java-based Pet Store application** using modern tools like Jenkins, SonarQube, OWASP Dependency Check, Docker, Trivy, Kubernetes, and MongoDB — designed for real-world enterprise DevOps scenarios.

---

## Tech Stack

- **Application**: Java WAR (JPetStore)
- **Build Tool**: Maven
- **CI/CD**: Jenkins Declarative Pipeline
- **Security Tools**: SonarQube, Trivy, OWASP Dependency Check
- **Containerization**: Docker (multi-stage + Distroless)
- **Orchestration**: Kubernetes
- **Database**: MongoDB (deployed as a pod)
- **Secrets/Configs**: ConfigMap, Secret

---

## CI/CD Pipeline Overview

### CI: Jenkins

1. Code checkout from GitHub
2. Maven compile and unit test
3. SonarQube static analysis
4. OWASP Dependency Check
5. WAR file creation
6. Docker image build with Distroless
7. Trivy image vulnerability scan
8. Docker push to Docker Hub

### CD: Kubernetes

- Deployed via `Deployment`, `Service`, `ConfigMap`, `Secret`
- MongoDB deployed as a separate pod with exposed service
- Environment variables and credentials injected securely

---

## Project Structure

.
├── Dockerfile
├── Jenkinsfile
├── README.md
│ petshop-deployment.yaml
│── petshop-configmap.yaml
── petshop-secret.yaml
│ ── petshop-service.yaml
│ ── mongodb-deployment.yaml
│ ── mongodb-service.yaml

## Dockerfile
FROM tomcat:9.0-jdk17-temurin AS tomcat-base
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ./jpetstore.war /usr/local/tomcat/webapps/ROOT.war

FROM gcr.io/distroless/java17-debian11:nonroot
COPY --from=tomcat-base /usr/local/tomcat /tomcat
WORKDIR /tomcat
USER nonroot
EXPOSE 8080
ENTRYPOINT ["java", "-cp", "bin/bootstrap.jar:bin/tomcat-juli.jar", "-Djava.security.egd=file:/dev/./urandom", "org.apache.catalina.startup.Bootstrap", "start"]

## Kubernetes Setup
 Pet Shop Deployment 
 kubectl apply -f k8s/petshop-configmap.yaml
 kubectl apply -f k8s/petshop-secret.yaml
 kubectl apply -f k8s/mongodb-deployment.yaml
 kubectl apply -f k8s/mongodb-service.yaml
 kubectl apply -f k8s/petshop-deployment.yaml
 kubectl apply -f k8s/petshop-service.yaml

## Then access the app at:
http://<NodeIP>:30080/jpetstore

## Security Tools Integrated
 Tool            Purpose                            
 --------------  ---------------------------------- 
 **SonarQube**   Static code analysis               
 **OWASP DC**    Dependency vulnerability scanning  
 **Trivy**       Container image vulnerability scan 
 **Distroless**  Secure base image for containers   
