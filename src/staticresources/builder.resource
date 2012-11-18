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
/*
  var xml = Blockly.Xml.textToDom(
      '<xml>' +
      '  <block type="spec_operation" x="185" y="145">' +
      '    <mutation items="2"></mutation>' +
      '    <title name="OP">AND</title>' +
      '    <value name="INP0">' +
      '      <block type="spec_negate" inline="false">' +
      '        <value name="SPEC">' +
      '          <block type="spec_field_compare" inline="false">' +
      '            <title name="FIELD">Name</title>' +
      '            <title name="OP">EQ</title>' +
      '          </block>' +
      '        </value>' +
      '      </block>' +
      '    </value>' +
      '  </block>' +
      '</xml>');
  Blockly.Xml.domToWorkspace(Blockly.mainWorkspace, xml);
*/
};

/*
 * Simulate a call to a RemoteAction. Or facade.
 */
Builder.exportJson = function(callback){

	var code = Blockly.Generator.workspaceToCode('JavaScript')
			.replace(/'/g,'"')
			.replace(';\n','');

	// Do something
	callback( code );

	console.log( code );
};
