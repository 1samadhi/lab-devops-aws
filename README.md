# Lab DevOps AWS — Pipeline CI/CD y Arquitectura Multinivel

## Propósito del repositorio

Este repositorio implementa un ciclo completo de DevOps que integra:

- **Control de versiones distribuido** con Git y GitHub
- **Contenerización** de una aplicación web estática con Docker y nginx
- **Automatización CI/CD** con GitHub Actions para construir y publicar la imagen en Docker Hub
- **Infraestructura de red segura en AWS** siguiendo el modelo de arquitectura de 3 capas

---

## Estrategia de ramas: Feature Branch Strategy

Se utiliza la estrategia de **Ramas de Características (Feature Branches)**.

### ¿En qué consiste?

Cada nueva funcionalidad o componente se desarrolla en una rama independiente
con el prefijo `feature/`, aislada de la rama principal `main`. Una vez completado
el trabajo, se genera un **Pull Request (PR)** para revisión antes de integrar
los cambios.

### Ramas del proyecto

| Rama               | Contenido                                      |
|--------------------|------------------------------------------------|
| `feature/frontend` | Página web estática (`index.html`)             |
| `feature/docker`   | Contenerización nginx (`Dockerfile`)           |
| `feature/docs`     | Documentación del proyecto (`README.md`)       |
| `main`             | Rama principal — integra todos los PRs         |

### Flujo de trabajo

```
feature/frontend  ──┐
feature/docker    ──┼──► Pull Request ──► main
feature/docs      ──┘
```

### ¿Por qué Feature Branches y no GitFlow completo?

GitFlow completo incluye ramas adicionales como `develop`, `release` y `hotfix`,
lo que es ideal para proyectos con ciclos de release formales. Para este
laboratorio, la estrategia de Feature Branches es suficiente y más directa:
cada componente se desarrolla en aislamiento y se integra a `main` mediante PR.

---

## Stack tecnológico

- **HTML5** — Página web estática
- **Docker / nginx:alpine** — Contenerización
- **GitHub Actions** — Pipeline CI/CD
- **Docker Hub** — Registro de imágenes (`samadhi1/lab-devops-aws`)
- **GitHub** — Repositorio (`1samadhi/lab-devops-aws`)
- **AWS VPC** — Infraestructura de red de 3 capas

---

## Pipeline CI/CD

El workflow `.github/workflows/main.yml` se activa automáticamente cuando se
abre un Pull Request hacia `main`. Ejecuta los siguientes pasos:

1. Login en Docker Hub usando los secrets `USER_DOCKERHUB` y `PASSWORD_DOCKERHUB`
2. Build de la imagen Docker
3. Push de la imagen al repositorio `samadhi1/lab-devops-aws` en Docker Hub

---

## Arquitectura de red AWS (Fase III)

La infraestructura sigue un modelo de 3 capas dentro de una VPC privada:

| Capa       | Tipo     | Security Group | Puertos permitidos          |
|------------|----------|----------------|-----------------------------|
| Web        | Pública  | GrupoWeb       | 80, 22, ICMP (0.0.0.0/0)   |
| App        | Privada  | GrupoApp       | 80, 22, ICMP (desde GrupoWeb) |
| Datos      | Privada  | GrupoDatos     | 3306, ICMP (desde GrupoApp) |
