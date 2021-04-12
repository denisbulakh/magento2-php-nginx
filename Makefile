install:
	@echo "Building application"
	@docker-compose build
	@docker-compose up -d
	@docker exec -it magento2-app bash -c "./install.sh"
	@docker-compose stop

start:
	@echo "Running application"
	@docker-compose up -d

stop:
	@docker-compose stop
