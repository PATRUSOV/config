import argparse
import sys
from typing import Callable, Any


class ArgumentParser(argparse.ArgumentParser):
    """Обертка на argparse с добавлением автоматической валидации."""

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._validators = {}

    def add_argument(
        self,
        *args,
        validator: Callable[[Any], Any] = None, 
        **kwargs
    ):
        """
        Функция для добавки своей кода для проверки и приведения аргумента к конечной форме.
        
        Аргументы:
            validator: функция для проверки/преобразования аргумента.
                        Принимает единственным аргументом Any возвращает Any.

        """
        argument = super().add_argument(*args, **kwargs)

        if validator is not None:
            if not callable(validator):
                raise TypeError(f"Validator for {argument.dest} must be callable")
            self._validators[argument.dest] = validator

        return argument
     
    def parse_args(self, *args, **kwargs) -> argparse.Namespace:
        """
        Обертка над argparse. Принимает те же значения что и оригинал, возвращает argparse.Namespace с именованными полями.
        Значения в полях модифицированы валидаторами.
        """
        parsed_args = super().parse_args(*args, **kwargs)
       

        for arg_name, validator in self._validators.items(): 
            arg_value = getattr(parsed_args, arg_name)
            try:
                validated_value = validator(arg_value)
            except Exception as e:
                raise argparse.ArgumentTypeError(
                    f"Invalid value for '{arg_name}': {e}"
                ) from e
            
        setattr(parsed_args, arg_name, validated_value)
        
        return parsed_args
            
        