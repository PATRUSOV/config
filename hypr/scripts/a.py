import argument

parser = argument.ArgumentParser()

def chil_validator(argument: str) -> str:
    return f"проверенный {argument}"

parser.add_argument("chill", validator=chil_validator,help = "чисто тест")

out = parser.parse_args()

print(out.chill)