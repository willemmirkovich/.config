from os import getenv, path, mkdir, makedirs
from argparse import ArgumentParser, Namespace
from jinja2 import Environment, FileSystemLoader
from datetime import datetime
from typing import Tuple


WORK_DIR = getenv('NOTES_WORK_DIR')
TEMPLATE_DIR = path.abspath(path.join(__file__, '..', 'templates'))


env = Environment(
    loader=FileSystemLoader(TEMPLATE_DIR)
)


def _normalize_name(name: str):
    return name.strip().lower().replace(' ', '_')

def _format_date(dt: datetime) -> str:
    return dt.strftime('%Y%m%d')

def _format_timpestamp(dt: datetime) -> str:
    return dt.strftime('%b %d, %Y %H:%M')

def daily_log(args: Namespace):
    
    try:
        date = args.date
        dt = datetime.fromisoformat(date)
    except (AttributeError, TypeError):
        dt = datetime.now().date()


    year, month, day = str(dt.year), str(dt.month), str(dt.day)
    weekday = dt.strftime('%A').lower()
    ts = _format_timpestamp(dt)

    dir = path.join(WORK_DIR, 'daily_logs', year, month)
    makedirs(dir, exist_ok=True)

    file_name = f'{day}_{weekday}.md'
    file_path = path.join(dir, file_name)

    template = env.get_template('daily_log.jinja.md')

    with open(file_path, 'w') as f:
        data = template.render(date=ts)
        f.write(data)


def meeting(args: Namespace):
    """
    Meeting note handler
    """
    dir = path.join(WORK_DIR, 'meetings')
    if not path.exists(dir):
        mkdir(dir)

    try:
        name = args.name
    except AttributeError:
        raise ValueError(f'meeting template requires `name` argument')
    
    template = env.get_template('meeting.jinja.md')

    dt = datetime.now()
    date = _format_date(dt)
    ts = _format_timpestamp(dt)
    clean_name = _normalize_name(name)
    file_name = f'{clean_name}_{date}.md'
    file_path = path.join(dir, file_name)

    with open(file_path, 'w') as f:
        data = template.render(name=name, timestamp=ts)
        f.write(data)

def main():

    if not isinstance(WORK_DIR, str):
        raise RuntimeError(f'`NOTES_WORK_DIR` env var is not set')

    if not path.isdir(WORK_DIR):
        raise ValueError(f'{WORK_DIR} is not a valid directory')

    parser = ArgumentParser()
    parser.add_argument('-t', '--template', required=False)

    # meeting template
    parser.add_argument('--name')

    # daily log template
    parser.add_argument('--date', help='iso formatted date (yyyy-mm-dd)')

    args = parser.parse_args()

    template = args.template


    match template:
        case 'meeting':
            meeting(args)
        case 'daily_log':
            daily_log(args)
        case _:
            daily_log(args)


if __name__ == "__main__":
    main()
