/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumberish,
  BytesLike,
  FunctionFragment,
  Result,
  Interface,
  EventFragment,
  AddressLike,
  ContractRunner,
  ContractMethod,
  Listener,
} from "ethers";
import type {
  TypedContractEvent,
  TypedDeferredTopicFilter,
  TypedEventLog,
  TypedLogDescription,
  TypedListener,
  TypedContractMethod,
} from "../common";

export declare namespace MessageContract {
  export type MessageStruct = {
    sender: AddressLike;
    content: string;
    timestamp: BigNumberish;
  };

  export type MessageStructOutput = [
    sender: string,
    content: string,
    timestamp: bigint
  ] & { sender: string; content: string; timestamp: bigint };
}

export interface MessageContractInterface extends Interface {
  getFunction(
    nameOrSignature: "getMessages" | "getSentMessages" | "sendMessage"
  ): FunctionFragment;

  getEvent(nameOrSignatureOrTopic: "MessageSent"): EventFragment;

  encodeFunctionData(
    functionFragment: "getMessages",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "getSentMessages",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "sendMessage",
    values: [AddressLike, string]
  ): string;

  decodeFunctionResult(
    functionFragment: "getMessages",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getSentMessages",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "sendMessage",
    data: BytesLike
  ): Result;
}

export namespace MessageSentEvent {
  export type InputTuple = [
    sender: AddressLike,
    recipient: AddressLike,
    content: string
  ];
  export type OutputTuple = [
    sender: string,
    recipient: string,
    content: string
  ];
  export interface OutputObject {
    sender: string;
    recipient: string;
    content: string;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export interface MessageContract extends BaseContract {
  connect(runner?: ContractRunner | null): MessageContract;
  waitForDeployment(): Promise<this>;

  interface: MessageContractInterface;

  queryFilter<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;
  queryFilter<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;

  on<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  on<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  once<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  once<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  listeners<TCEvent extends TypedContractEvent>(
    event: TCEvent
  ): Promise<Array<TypedListener<TCEvent>>>;
  listeners(eventName?: string): Promise<Array<Listener>>;
  removeAllListeners<TCEvent extends TypedContractEvent>(
    event?: TCEvent
  ): Promise<this>;

  getMessages: TypedContractMethod<
    [recipient: AddressLike],
    [
      [string[], string[], bigint[]] & {
        senders: string[];
        contents: string[];
        timestamps: bigint[];
      }
    ],
    "view"
  >;

  getSentMessages: TypedContractMethod<
    [],
    [MessageContract.MessageStructOutput[]],
    "view"
  >;

  sendMessage: TypedContractMethod<
    [recipient: AddressLike, content: string],
    [void],
    "nonpayable"
  >;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "getMessages"
  ): TypedContractMethod<
    [recipient: AddressLike],
    [
      [string[], string[], bigint[]] & {
        senders: string[];
        contents: string[];
        timestamps: bigint[];
      }
    ],
    "view"
  >;
  getFunction(
    nameOrSignature: "getSentMessages"
  ): TypedContractMethod<[], [MessageContract.MessageStructOutput[]], "view">;
  getFunction(
    nameOrSignature: "sendMessage"
  ): TypedContractMethod<
    [recipient: AddressLike, content: string],
    [void],
    "nonpayable"
  >;

  getEvent(
    key: "MessageSent"
  ): TypedContractEvent<
    MessageSentEvent.InputTuple,
    MessageSentEvent.OutputTuple,
    MessageSentEvent.OutputObject
  >;

  filters: {
    "MessageSent(address,address,string)": TypedContractEvent<
      MessageSentEvent.InputTuple,
      MessageSentEvent.OutputTuple,
      MessageSentEvent.OutputObject
    >;
    MessageSent: TypedContractEvent<
      MessageSentEvent.InputTuple,
      MessageSentEvent.OutputTuple,
      MessageSentEvent.OutputObject
    >;
  };
}
