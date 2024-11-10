# Use a base image that includes Quarto
FROM analythium/r2u-quarto:20.04

# Set the working directory in the container
WORKDIR /site

# Copy your Quarto project files into the container
COPY . /site

# Run Quarto to render the website in the _site directory
RUN quarto render .

# Use a simple web server to serve the static files
RUN apt-get update && apt-get install -y nginx
RUN rm /etc/nginx/sites-enabled/default
RUN echo "server { listen 80; root /site/_site; }" > /etc/nginx/sites-enabled/quarto

# Expose the port and set the default command
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
