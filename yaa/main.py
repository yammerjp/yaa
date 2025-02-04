from chainlit.utils import mount_chainlit
from fastapi import FastAPI

app = FastAPI()

print("please open http://localhost:8765/chainlit/")


@app.get("/app")
def read_main():
    return {"message": "Hello World from main app"}

mount_chainlit(app=app, target="yaa/chainlit_entrypoint.py", path="/chainlit")
