from flask import Blueprint, render_template

bp = Blueprint('job_history', __name__, url_prefix='/jobs')


@bp.route('/')
def index():
    return render_template('jobs.html')