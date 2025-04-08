from os import getenv, path
from argparse import ArgumentParser, Namespace


WORK_DIR = getenv('NOTES_WORK_DIR')



def meeting(args: Namespace):
    pass


def main():

    if not isinstance(WORK_DIR, str):
        raise RuntimeError(f'`NOTES_WORK_DIR` env var is not set')

    if not path.isdir(WORK_DIR):
        raise ValueError(f'{WORK_DIR} is not a valid directory')

    parser = ArgumentParser()
    parser.add_argument('template')

    # meeting template

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
