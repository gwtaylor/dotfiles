from IPython import ipapi

def main():
    ip = ipapi.get()
    ip.ex('from reimport import reimport,modified')

main()
                        
