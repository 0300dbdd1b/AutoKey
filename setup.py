from setuptools import setup, find_packages

setup(
    name='AutoKey',
    version='0.0.1',
    author='0300dbdd1b',
    author_email='_@_',
    description='AutoHotKey but on every system.',
    url='https://github.com/0300dbdd1b/AutoKey',
    packages=find_packages(),
    install_requires=[
    ],
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
    ],
    python_requires='>=3.6',
    entry_points={
        'console_scripts': [
            'autokey=AutoKey.AutoKey:main'
        ],
    },
)

