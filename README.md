# Verify environment variables

Is a bash script that compare all variables in use on code with .env file and generate an output showing what variables are not found in .env file

## How to use

The script recieve three params optional:
  
| Command | Description | Default
| --- | --- | --- |
| -s, --search | Search directory | src
| -n, --name | Name of env file | env
| -e, --exclude | Exclude directories to search | node_modules
| -h, --help | Display this help text and exit | -

## Usage

Copy script inside your project

```bash
./verify_env.sh -s src -n env -e dist,node_modules
```

## Contributing
Pull requests are welcome! :smiley: 
