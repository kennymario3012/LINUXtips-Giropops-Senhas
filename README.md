# Linuxtips-Giropops-Senhas

**Project: LINUXtips-Giropops-Senhas**

This project provides a secure password management system using Docker containers. 

**Prerequisites:**

- Docker installed and running on your system. You can find installation instructions at [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/).

**Getting Started**

1. **Clone the Repository:**

   ```bash
   git clone git@github.com:kennymario3012/LINUXtips-Giropops-Senhas.git
   ```

   This command clones the project repository from GitHub to your local machine.

2. **Create Docker Network:**

   ```bash
   docker network create giropops-senhas
   ```

   This command creates a Docker network named `giropops-senhas` to isolate the containers and facilitate communication.

3. **Build the Main Application Image (Replace `<seu_usuario_docker_hub>` with your Docker Hub username):**

   ```bash
   docker image build -t <seu_usuario_docker_hub>/linuxtips-giropops-senhas:2.0 .
   ```

   This command builds a Docker image for the main application code from the current directory (`.`) and tags it with the following information:

   - `<seu_usuario_docker_hub>`: Replace this with your actual Docker Hub username.
   - `linuxtips-giropops-senhas`: The image name.
   - `2.0`: The image version (you can adjust this as needed).

4. **Build the Redis Server Image (Replace `<seu_usuario_docker_hub>` with your Docker Hub username):**

   ```bash
   docker image build -t <seu_usuario_docker_hub>/linuxtips-giropops-senhas-redis:2.0 ./redis-server
   ```

   This command builds a separate Docker image specifically for the Redis server used for data storage in the `redis-server` directory and tags it similarly to the main application image.

5. **Run the Redis Server Container:**

   ```bash
   docker container run -d -p 6379:6379 --name redis-server kennymario/linuxtips-giropops-senhas-redis:1.0
   ```

   This command runs a Docker container for the Redis server image:

   - `-d`: Runs the container in detached mode (background).
   - `-p 6379:6379`: Maps the container's port 6379 (the default Redis port) to the host's port 6379, making it accessible from outside the container.
   - `--name redis-server`: Gives the container a friendly name for easier identification.
   - `kennymario/linuxtips-giropops-senhas-redis:1.0`: Specifies the Docker image to use (replace `kennymario` with your username if different).
   - **Note:** You may need to adjust the version number (`1.0`) if you've made changes to the Redis server container.

6. **Run the Main Application Container:**

   ```bash
   docker container run -d -p 5000:5000 --name giropops-senhas <seu_usuario_docker_hub>/linuxtips-giropops-senhas:2.0
   ```

   This command runs a Docker container for the main application image:

   - `-d`: Runs the container in detached mode (background).
   - `-p 5000:5000`: Maps the container's port 5000 (the application's port) to the host's port 5000, allowing you to access the application from your web browser at `http://localhost:5000` (or the corresponding IP address if accessed remotely).
   - `--name giropops-senhas`: Gives the container a friendly name for easier identification.
   - `<seu_usuario_docker_hub>/linuxtips-giropops-senhas:2.0`: Specifies the Docker image to use (replace `<seu_usuario_docker_hub>` with your username).
   - **Note:** You may need to adjust the version number (`2.0`) if you've made changes to the main application code.

**Usage (After running the containers):**

1. Access the password management application in your web browser at `http://localhost:5000`.

**Additional Notes:**

- Remember to replace `<seu_usuario_docker_hub>` with your actual