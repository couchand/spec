'use strict';

var HUE = 1;
var ANGLE = 39;

var OPERATION_COLOUR = HUE;
var SPEC_COLOUR = ANGLE + OPERATION_COLOUR;
var FIELD_COLOUR = 180 + OPERATION_COLOUR;
var VALUE_COLOUR = ANGLE + FIELD_COLOUR;

Blockly.JavaScript = Blockly.Generator.get('JavaScript');

Blockly.Language.spec_field_compare = {
  // Comparison operator.
  category: 'Specs',
  helpUrl: '',
  init: function() {
    this.setColour(SPEC_COLOUR);
    this.setOutput(true, 'Specification');
    this.appendValueInput('FIELD')
        .setCheck('Field')
        .appendTitle('field');
    this.appendValueInput('VALUE')
        .setCheck([Number, Boolean, String])
        .setAlign(Blockly.ALIGN_RIGHT)
        .appendTitle(new Blockly.FieldDropdown(this.OPERATORS), 'OP');
    // Assign 'this' to a variable for use in the tooltip closure below.
    var thisBlock = this;
    this.setTooltip(function() {
      var op = thisBlock.getTitleValue('OP');
      return thisBlock.TOOLTIPS[op];
    });
  }
};

Blockly.Language.spec_field_compare.OPERATORS =
    [['=', 'EQ'],
     ['\u2260', 'NEQ'],
     ['<', 'LT'],
     ['\u2264', 'LTE'],
     ['>', 'GT'],
     ['\u2265', 'GTE']];

Blockly.Language.spec_field_compare.TOOLTIPS = {
  EQ: 'Field equal to',
  NEQ: 'Field not equal to',
  LT: 'Field less than',
  LTE: 'Field not exceeding',
  GT: 'Field exceeding',
  GTE: 'Field not less than'
};

Blockly.JavaScript.spec_field_compare = function() {

	var operator = this.getTitleValue('OP');
	var nodeType;
	var field = Blockly.JavaScript.valueToCode(this, 'FIELD', Blockly.JavaScript.ORDER_COMMA) || 'Id';
	var value = Blockly.JavaScript.valueToCode(this, 'VALUE', Blockly.JavaScript.ORDER_COMMA) || 'null';

	switch(operator){
	case 'EQ':
		nodeType = 'FieldEqualTo';
		break;
	case 'NEQ':
		nodeType = 'FieldNotEqualTo';
		break;
	default:
		nodeType = 'FieldBoundSpecification';
	}

	var code = '{ "node": ' + nodeType +
                   ', "field": "' + field + '"' +
                   ', "value": ' + value + ' }';

	return [code, Blockly.JavaScript.ORDER_ATOMIC];
};

Blockly.Language.spec_field_value = {
  // Field description for field compare
  category: 'Fields',
  helpUrl: '',
  init: function() {
    this.setColour(FIELD_COLOUR);
    this.setOutput(true, 'Field');
    this.appendDummyInput('FIELD')
        .appendTitle(new Blockly.FieldDropdown(this.FIELDS), 'FIELD');
    this.setTooltip('The field to compare against');
  }
};

Blockly.Language.spec_field_value.FIELDS =
    [['Name', 'Name'],
     ['Custom Field', 'Custom__c']];

Blockly.JavaScript.spec_field_value = function() {

	var field = this.getTitleValue('FIELD');
	return [field, Blockly.JavaScript.ORDER_ATOMIC];
};

Blockly.Language.spec_operation = {
  // Logical operations: 'and', 'or'.
  category: 'Logic',
  helpUrl: '',
  init: function() {
    this.setColour(OPERATION_COLOUR);
    this.setOutput(true, 'Specification');
    this.appendValueInput('INP0')
        .setCheck('Specification')
        .appendTitle(new Blockly.FieldDropdown(this.OPERATORS), 'OP');
    this.appendValueInput('INP1')
        .setCheck('Specification')
    this.setMutator(new Blockly.Mutator(['spec_operation_item']));
    this.itemCount_ = 2;
    // Assign 'this' to a variable for use in the tooltip closure below.
    var thisBlock = this;
    this.setTooltip(function() {
      var op = thisBlock.getTitleValue('OP');
      return Blockly.Language.spec_operation.TOOLTIPS[op];
    });
  },
  mutationToDom: function() {
    var container = document.createElement('mutation');
    container.setAttribute('items', this.itemCount_);
    return container;
  },
  domToMutation: function(xmlElement) {
    for (var x = 0; x < this.itemCount_; x++) {
      this.removeInput('INP' + x);
    }
    this.itemCount_ = window.parseInt(xmlElement.getAttribute('items'), 10);
    for (var x = 0; x < this.itemCount_; x++) {
      var input = this.appendValueInput('INP' + x)
                      .setCheck('Specification');
      if (x == 0) {
        input.appendTitle(new Blockly.FieldDropdown(this.OPERATORS), 'OP');
      }
    }
    if (this.itemCount_ == 0) {
      this.appendDummyInput('EMPTY')
          .appendTitle(new Blockly.FieldDropdown(this.OPERATORS), 'OP');
    }
  },
  decompose: function(workspace) {
    var containerBlock = new Blockly.Block(workspace,
                                           'spec_operation_container');
    containerBlock.initSvg();
    var connection = containerBlock.getInput('STACK').connection;
    for (var x = 0; x < this.itemCount_; x++) {
      var itemBlock = new Blockly.Block(workspace, 'spec_operation_item');
      itemBlock.initSvg();
      connection.connect(itemBlock.previousConnection);
      connection = itemBlock.nextConnection;
    }
    return containerBlock;
  },
  compose: function(containerBlock) {
    // Disconnect all input blocks and remove all inputs.
    if (this.itemCount_ == 0) {
      this.removeInput('EMPTY');
    } else {
      for (var x = this.itemCount_ - 1; x >= 0; x--) {
        this.removeInput('INP' + x);
      }
    }
    this.itemCount_ = 0;
    // Rebuild the block's inputs.
    var itemBlock = containerBlock.getInputTargetBlock('STACK');
    while (itemBlock) {
      var input = this.appendValueInput('INP' + this.itemCount_);
      if (this.itemCount_ == 0) {
        input.appendTitle(new Blockly.FieldDropdown(this.OPERATORS), 'OP');
      }
      // Reconnect any child blocks.
      if (itemBlock.valueConnection_) {
        input.connection.connect(itemBlock.valueConnection_);
      }
      this.itemCount_++;
      itemBlock = itemBlock.nextConnection &&
          itemBlock.nextConnection.targetBlock();
    }
    if (this.itemCount_ == 0) {
      this.appendDummyInput('EMPTY')
          .appendTitle(new Blockly.FieldDropdown(this.OPERATORS), 'OP');
    }
  },
  saveConnections: function(containerBlock) {
    // Store a pointer to any connected child blocks.
    var itemBlock = containerBlock.getInputTargetBlock('STACK');
    var x = 0;
    while (itemBlock) {
      var input = this.getInput('INP' + x);
      itemBlock.valueConnection_ = input && input.connection.targetConnection;
      x++;
      itemBlock = itemBlock.nextConnection &&
          itemBlock.nextConnection.targetBlock();
    }
  }
};

Blockly.Language.spec_operation.OPERATORS =
    [['and', 'AND'],
     ['or', 'OR']];

Blockly.Language.spec_operation.TOOLTIPS = {
  AND: 'A logical conjunction of the Specifications',
  OR: 'A logical disjunction of the Specifications'
};

Blockly.Language.spec_operation_container = {
  // Container.
  init: function() {
    this.setColour(160);
    this.appendDummyInput()
        .appendTitle('statement');
    this.appendStatementInput('STACK');
    this.setTooltip('A logical statement is a combination of clauses.');
    this.contextMenu = false;
  }
};

Blockly.Language.spec_operation_item = {
  // Add items.
  init: function() {
    this.setColour(160);
    this.appendDummyInput()
        .appendTitle('clause');
    this.setPreviousStatement(true);
    this.setNextStatement(true);
    this.setTooltip('Yet another clause in this logical statement.');
    this.contextMenu = false;
  }
};

Blockly.Language.spec_negate = {
  // Negation.
  category: 'Logic',
  helpUrl: '',
  init: function() {
    this.setColour(OPERATION_COLOUR);
    this.setOutput(true, 'Specification');
    this.appendValueInput('SPEC')
        .setCheck('Specification')
        .appendTitle('not');
    this.setTooltip('The inverse of the Specification passed in');
  }
};

function init( blocklyPath ) {

  // Whitelist of blocks to keep.
  var newLanguage = {};
  var keepers = ['spec_field_compare', 'spec_field_value',
                 'spec_operation', 'spec_negate',
                 'math_number', 'text'];
  for (var x = 0; x < keepers.length; x++) {
    newLanguage[keepers[x]] = Blockly.Language[keepers[x]];
  }
  // Fold math and text categories into value category.
  for (var name in newLanguage) {
    if (newLanguage[name].category == 'Math' || newLanguage[name].category == 'Text') {
      newLanguage[name].category = 'Value';
      newLanguage[name].init = ((function(oldInit){
        return function(){
            oldInit.apply(this);
            this.setColour(VALUE_COLOUR);
        };
      })(newLanguage[name].init));
    }
  }
  Blockly.Language = newLanguage;

  Blockly.inject(document.body, {path: blocklyPath});

  if (window.parent.Builder) {
    // Let the top-level application know that Blockly is ready.
    window.parent.Builder.init(Blockly);
  } else {
    // Attempt to diagnose the problem.
    var msg = 'Error: Unable to communicate between frames.\n\n';
    if (window.parent == window) {
      msg += 'Try loading index.html instead of frame.html';
    } else if (window.location.protocol == 'file:') {
      msg += 'This may be due to a security restriction preventing\n' +
          'access when using the file:// protocol.\n' +
          'http://code.google.com/p/chromium/issues/detail?id=47416';
    }
    alert(msg);
  }
}
