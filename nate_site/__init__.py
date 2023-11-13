import os

from flask import Flask


def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)

    app.config.from_mapping(
        SECRET_KEY="dev", DATABASE=os.path.join(app.instance_path, "flaskr.sqlite")
    )

    if test_config is None:
        app.config.from_pyfile("config.py", silent=True)
    else:
        app.config.from_mapping(test_config)

    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from . import homepage, about_me, jobs

    app.register_blueprint(about_me.bp)
    app.register_blueprint(homepage.bp)
    app.register_blueprint(jobs.bp)

    app.add_url_rule('/', endpoint='index')

    return app

