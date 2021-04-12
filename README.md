# magento2-php-nginx

Ready Docker Compose configuration for Magento 2, designed for local development purposes

> **Important!** Solution is *not* designed to be used on production

### Usage



To pull Magento2 from repository and install it in the container:
```shell
make install
```

To start installed instance:
```shell
make start
```
Now navigate to http://localhost:8080 to see freshly installed Magento 2

To stop the instance:
```shell
make stop
```

By default, all the source code is pulled into the container itself. If you want to connect a volume, you can create `docker-compose.override.yml` file with the following content:

```yaml
version: "3.3"
services:
  magento2-app:
    volumes:
      - ./:/usr/src/app
```

This will use current project directory as a volume for the `magento-app` container

###Have fun!

#### Denys Bulakh
- Github: https://github.com/denisbulakh/magento2-php-nginx
- Email: [denys@bulakhweb.com](mailto:denys@bulakhweb.com)
- LinkedIn: https://www.linkedin.com/in/denysbulakh/
