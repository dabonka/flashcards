'use strict';

// Register `cardCheck` component, along with its associated controller and template
angular.
  module('cardCheck').
  component('cardCheck', {
    templateUrl: 'card-check/card-check.template.html',
    controller: ['Card',
      function CardCheckController(Card) {

        var self = this;

        self.random_card = function() {
          Card.get_random_card().$promise.then(function(result){
            self.card = result.data;
          });
        };

        self.$onInit = function() {
          self.random_card(); // Берем при инициации значение рандомной карты
        };

        self.formSubmit = function(event) {
          event.preventDefault();

          self.correct = false;
          self.incorrect = false;

          var user_card_data = {translated_text: self.user_variant, card_id: self.card.card_id}; 
          //Собрал данные пользователя и отправляю в следующей строке

          Card.compare(user_card_data).$promise.then(function(result_of_compare){
          // Дальше мы получаем из сервиса результат проверки и анализируем его

              if (result_of_compare.status == "success"){
                self.correct = true;
                console.log ("Правильно"); // Выводим сообщение о правильном переводе

              } else {
                self.incorrect = true;
                console.log ("Ошибка"); // Выводим сообщение об ошибке
              }

            self.random_card(); // Повторно берем значение рандомной карты

          });
        };
      }
    ]
  });
