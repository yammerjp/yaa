.PHONY: dev
dev:
	poetry run uvicorn yaa.main:app --port 8765
