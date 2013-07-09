@class StateMachine;
@class StateMachineException;
@class State;
@class StateError;
@protocol StateMachineDelegate <NSObject>
@required
- (void)stateMachineStateTransition:(State*)enteringState;
- (void)stateMachineEndStateReached:(StateMachine*)machine;
- (void)logStateError:(StateError*)stateError;

@optional
- (void)nextStateByName:(NSString*)stateName stateData:(id)stateData;
@end

