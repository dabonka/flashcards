'use strict';

describe('cardCheck', function() {

  // Load the module that contains the `cardCheck` component before each test
  beforeEach(module('cardCheck'));

  // Test the controller
  describe('CardCheckController', function() {
    var $httpBackend, ctrl;

    // The injector ignores leading and trailing underscores here (i.e. _$httpBackend_).
    // This allows us to inject a service and assign it to a variable with the same name
    // as the service while avoiding a name conflict.
    beforeEach(inject(function($componentController, _$httpBackend_) {
      $httpBackend = _$httpBackend_;
      $httpBackend.expectGET('cards/cards.json')
                  .respond([{original_text: 'fox'}, {original_text: 'bear'}]);

      ctrl = $componentController('cardCheck');
    }));

    it('should create a `cards` property with 2 cards fetched with `$http`', function() {
      expect(ctrl.cards).toBeUndefined();

      $httpBackend.flush();
      expect(ctrl.cards).toEqual([{original_text: 'fox'}, {original_text: 'bear'}]);
    });

    it('should set a default value for the `orderProp` property', function() {
      expect(ctrl.orderProp).toBe('card_id');
    });

  });

});