'use strict';

var Builder = {};

/**
 * Initialize Blockly and the maze.  Called on page load.
 * @param {!Blockly} blockly Instance of Blockly from iframe.
 */
Builder.init = function(blockly) {

  window.Blockly = blockly;

  window.onbeforeunload = function() {
    if (Blockly.mainWorkspace.getAllBlocks().length > 1) {
      return 'Leaving this page will result in the loss of your work.';
    }
    return null;
  };

  // Load the editor with a starting block.
  var xml = Blockly.Xml.textToDom(
      '<xml>' +
      '  <block type="spec_operation" x="85" y="100"></block>' +
      '</xml>');
  Blockly.Xml.domToWorkspace(Blockly.mainWorkspace, xml);
};

/*
 * Simulate a call to a RemoteAction. Or facade.
 */
Builder.reloadMatches = function(){

	// Do something
};
