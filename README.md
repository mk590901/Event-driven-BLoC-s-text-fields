# Event driven BLoC's text fields

## Introduction

The collection of buttons and switches (https://github.com/mk590901/Event-driven-BLoC-s-switch-widgets) is supplemented now with text fields created using __BLoC__ technology. So far there are only two of them: __MultilineTextField__ and __EasyTextField__. Both are based on the __TextField__ widget. Text input is accompanied by calls to callback functions, in which you can embed the logic of interaction between the widget and a group of other widgets. Combined with the buttons created earlier, this can make some tasks easier. The demo provides an example of filling out two fields: __account__ and __password__ with an indirect effect on the __login__ button: it becomes available for use if both fields aren't empty.

## TextBloc State Machine

![text_field](https://github.com/mk590901/text_bloc/assets/125393245/4bd199ae-e379-4d8d-865b-8ee5210f56c9)

## Movie

https://github.com/mk590901/text_bloc/assets/125393245/a4c93540-f90b-4845-90d6-e05af8e77088


