# Constraints

Custom constraints for verifying MATLAB test behavior and test data.

## Available Constraints

* [`DatetimeTolerance`](DatetimeTolerance.md) - allow non-exact
  matching of datetimes and durations.
* [`HasStringLengthLessThan`](HasStringLengthLessThan.md) - check
  that string length is less than a set value.
* [`IsEqualVector`](IsEqualVector.md) - are two vectors equal
  irrespective of row or column orientation.
* [`IsEquivalentText`](IsEquivalentText.md) - is text equal
  irrespective of `string`, `char`, or `cellstr` type.
* [`IsSamePathAs`](IsSamePathAs.md) - are paths equal irrespective
  of data type, file separator, and Windows capitalization.
* [`MatchesStatistically`](MatchesStatistically.md) - are at least
  a certain percentage of elements equal within a tolerance.
* [`NotifiesEvent`](NotifiesEvent.md) - check that a function or
  method call notifies an event.
* [`NotifiesPropertyEvent`](NotifiesPropertyEvent.md) - check that
  a function or method call notifies a property event.
* [`PassesEventData`](PassesEventData.md) - check that a function
  or method call notifies an event with custom event data.

## See Also

* [Test Framework Extensions Toolbox](index.md)
* [Fixtures](Fixtures.md)
* [Plugins](Plugins.md)
* [Alias](Alias.md)
