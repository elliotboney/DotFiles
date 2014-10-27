(function() {
  var ColorVariablesParsing, Mixin, Q, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Mixin = require('mixto');

  Q = require('q');

  module.exports = ColorVariablesParsing = (function(_super) {
    __extends(ColorVariablesParsing, _super);

    function ColorVariablesParsing() {
      _ref = ColorVariablesParsing.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ColorVariablesParsing.variableExpressions = {};

    ColorVariablesParsing.addVariableExpression = function(name, regexp) {
      return this.variableExpressions[name] = regexp;
    };

    ColorVariablesParsing.removeVariableExpression = function(name) {
      return delete this.variableExpressions[name];
    };

    ColorVariablesParsing.scanBufferForVariables = function(buffer, callback) {
      return this.scanBufferForVariablesInRange(buffer, [[0, 0], [Infinity, Infinity]], callback);
    };

    ColorVariablesParsing.scanBufferForVariablesInRange = function(buffer, range, callback) {
      var Range, bufferEnd, bufferStart, bufferText, end, hasResults, key, lastIndex, match, re, res, results, start, value, _ref1;
      if (buffer == null) {
        throw new Error('Missing buffer');
      }
      Range = buffer.constructor.Range;
      range = Range.fromObject(range);
      hasResults = false;
      bufferStart = buffer.characterIndexForPosition(range.start);
      bufferEnd = buffer.characterIndexForPosition(range.end);
      bufferText = buffer.getText().slice(bufferStart, +bufferEnd + 1 || 9e9);
      re = this.getVariableExpressionsRegexp();
      results = {};
      re.lastIndex = bufferStart;
      while (match = re.exec(bufferText)) {
        hasResults = true;
        lastIndex = re.lastIndex;
        if (lastIndex > bufferEnd) {
          break;
        }
        res = match[0];
        _ref1 = this.extractVariableElements(res), key = _ref1[0], value = _ref1[1];
        start = buffer.positionForCharacterIndex(lastIndex - res.length);
        end = buffer.positionForCharacterIndex(lastIndex);
        range = [[start.row, start.column], [end.row, end.column]];
        if (this.canHandle(value) || ((results[value] != null) && results[value].isColor)) {
          results[key] = {
            value: value,
            range: range,
            isColor: true
          };
          if (typeof callback === "function") {
            callback(match);
          }
        } else {
          results[key] = {
            value: value,
            range: range,
            isColor: false
          };
          if (typeof callback === "function") {
            callback(match);
          }
        }
      }
      return Q.fcall(function() {
        return results;
      });
    };

    ColorVariablesParsing.extractVariableElements = function(string) {
      var k, key, m, ore, re, value, _, _ref1;
      _ref1 = this.variableExpressions;
      for (k in _ref1) {
        re = _ref1[k];
        ore = new RegExp(re);
        m = ore.exec(string);
        if (m != null) {
          _ = m[0], key = m[1], value = m[2];
          return [key, value];
        }
      }
      return null;
    };

    ColorVariablesParsing.getVariableExpressionsRegexp = function() {
      var k, regex, v;
      regex = ((function() {
        var _ref1, _results;
        _ref1 = this.variableExpressions;
        _results = [];
        for (k in _ref1) {
          v = _ref1[k];
          _results.push(v);
        }
        return _results;
      }).call(this)).join('|');
      return new RegExp("(" + regex + ")", 'gm');
    };

    return ColorVariablesParsing;

  })(Mixin);

}).call(this);
