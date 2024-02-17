import flet as ft
from flet import *
from backend import application.Application


def main(page: ft.Page):

    application = Application()

    def on_click_start():
        application.startGame(num_iterations.value)

    num_iterations = ft.TextField(
        hint_text='Enter number of rounds',
        width=300)
    page.add(ft.Row(alignment=MainAxisAlignment.SPACE_EVENLY,
                    controls=[
                        num_iterations,
                        ft.ElevatedButton(
                            'Start Game',
                            on_click=on_click_start,
                        )
                    ]
                    )
             )


ft.app(target=main)
