// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_manager.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars

mixin _$ConnectionManager on _ConnectionManager, Store {
  Computed<List<Message>> _$currentMessagesComputed;

  @override
  List<Message> get currentMessages => (_$currentMessagesComputed ??=
          Computed<List<Message>>(() => super.currentMessages))
      .value;

  final _$membersAtom = Atom(name: '_ConnectionManager.members');

  @override
  ObservableList<Member> get members {
    _$membersAtom.context.enforceReadPolicy(_$membersAtom);
    _$membersAtom.reportObserved();
    return super.members;
  }

  @override
  set members(ObservableList<Member> value) {
    _$membersAtom.context.conditionallyRunInAction(() {
      super.members = value;
      _$membersAtom.reportChanged();
    }, _$membersAtom, name: '${_$membersAtom.name}_set');
  }

  final _$activeMemberAtom = Atom(name: '_ConnectionManager.activeMember');

  @override
  int get activeMember {
    _$activeMemberAtom.context.enforceReadPolicy(_$activeMemberAtom);
    _$activeMemberAtom.reportObserved();
    return super.activeMember;
  }

  @override
  set activeMember(int value) {
    _$activeMemberAtom.context.conditionallyRunInAction(() {
      super.activeMember = value;
      _$activeMemberAtom.reportChanged();
    }, _$activeMemberAtom, name: '${_$activeMemberAtom.name}_set');
  }

  final _$socketStateAtom = Atom(name: '_ConnectionManager.socketState');

  @override
  SocketState get socketState {
    _$socketStateAtom.context.enforceReadPolicy(_$socketStateAtom);
    _$socketStateAtom.reportObserved();
    return super.socketState;
  }

  @override
  set socketState(SocketState value) {
    _$socketStateAtom.context.conditionallyRunInAction(() {
      super.socketState = value;
      _$socketStateAtom.reportChanged();
    }, _$socketStateAtom, name: '${_$socketStateAtom.name}_set');
  }

  final _$messagesAtom = Atom(name: '_ConnectionManager.messages');

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
  }

  final _$_handleDataAsyncAction = AsyncAction('_handleData');

  @override
  Future _handleData(List<int> data) {
    return _$_handleDataAsyncAction.run(() => super._handleData(data));
  }

  final _$sendMessageAsyncAction = AsyncAction('sendMessage');

  @override
  Future sendMessage(String data) {
    return _$sendMessageAsyncAction.run(() => super.sendMessage(data));
  }

  final _$_ConnectionManagerActionController =
      ActionController(name: '_ConnectionManager');

  @override
  dynamic setActiveChat(int i) {
    final _$actionInfo = _$_ConnectionManagerActionController.startAction();
    try {
      return super.setActiveChat(i);
    } finally {
      _$_ConnectionManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void notifyChange() {
    final _$actionInfo = _$_ConnectionManagerActionController.startAction();
    try {
      return super.notifyChange();
    } finally {
      _$_ConnectionManagerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sendHello(String userName) {
    final _$actionInfo = _$_ConnectionManagerActionController.startAction();
    try {
      return super.sendHello(userName);
    } finally {
      _$_ConnectionManagerActionController.endAction(_$actionInfo);
    }
  }
}
