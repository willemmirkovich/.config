from os import getenv, path, mkdir
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


def _current_timpestamp() -> Tuple[str, str]:
    dt = datetime.now()
    date = dt.strftime('%Y%m%d')
    timestamp = dt.strftime('%b %d, %Y %H:%M')
    return date, timestamp 


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

    date, ts = _current_timpestamp()
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
    parser.add_argument('template')

    # meeting template
    parser.add_argument('--name')

    # daily log template

    args = parser.parse_args()

    template = args.template


    match template:
        case 'meeting':
            meeting(args)
        case _:
            raise ValueError(f'template {template} is not handled')


if __name__ == "__main__":
    main()
