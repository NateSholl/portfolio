from flask import Blueprint, render_template

bp = Blueprint('about_me', __name__, url_prefix='/about')


@bp.route('/')
def index():
    return render_template('about_me.html')