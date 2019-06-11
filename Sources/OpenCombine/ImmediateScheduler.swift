//
//  ImmediateScheduler.swift
//  
//
//  Created by Sergej Jaskiewicz on 11.06.2019.
//

/// A scheduler for performing synchronous actions.
///
/// You can only use this scheduler for immediate actions. If you attempt to schedule actions after a specific date,
/// the scheduler produces a fatal error.
public struct ImmediateScheduler: Scheduler {

    /// The time type used by the immediate scheduler.
    public struct SchedulerTimeType: Strideable {

        fileprivate init() {}

        /// Returns the distance to another immediate scheduler time; this distance is always `0` in the context of
        /// an immediate scheduler.
        ///
        /// - Parameter other: The other scheduler time.
        /// - Returns: `0`, as a `Stride`.
        public func distance(to other: SchedulerTimeType) -> Stride { 0 }

        /// Advances the time by the specified amount; this is meaningless in the context of an immediate scheduler.
        ///
        /// - Parameter n: The amount to advance by. The `ImmediateScheduler` ignores this value.
        /// - Returns: An empty `SchedulerTimeType`.
        public func advanced(by n: Stride) -> SchedulerTimeType { SchedulerTimeType() }

        /// The increment by which the immediate scheduler counts time.
        public struct Stride: ExpressibleByFloatLiteral,
                              Comparable,
                              SignedNumeric,
                              Codable,
                              SchedulerTimeIntervalConvertible {

            public typealias FloatLiteralType = Double

            public typealias IntegerLiteralType = Int

            public typealias Magnitude = Int

            public var magnitude: Int

            @inlinable
            public init(_ value: Int) {
                magnitude = value
            }

            @inlinable
            public init(integerLiteral value: Int) {
                self.init(value)
            }

            @inlinable
            public init(floatLiteral value: Double) {
                self.init(Int(value))
            }

            @inlinable
            public init?<T: BinaryInteger>(exactly source: T) {
                guard let magnitude = Int(exactly: source) else {
                    return nil
                }
                self.init(magnitude)
            }

            @inlinable
            public static func < (lhs: Stride, rhs: Stride) -> Bool {
                lhs.magnitude < rhs.magnitude
            }

            @inlinable
            public static func * (lhs: Stride, rhs: Stride) -> Stride {
                Stride(lhs.magnitude * rhs.magnitude)
            }

            @inlinable
            public static func + (lhs: Stride, rhs: Stride) -> Stride {
                Stride(lhs.magnitude + rhs.magnitude)
            }

            @inlinable
            public static func - (lhs: Stride, rhs: Stride) -> Stride {
                Stride(lhs.magnitude - rhs.magnitude)
            }

            @inlinable
            public static func -= (lhs: inout Stride, rhs: Stride) {
                lhs.magnitude -= rhs.magnitude
            }

            public static func *= (lhs: inout Stride, rhs: Stride) {
                lhs.magnitude *= rhs.magnitude
            }

            public static func += (lhs: inout Stride, rhs: Stride) {
                lhs.magnitude += rhs.magnitude
            }

            public static func seconds(_ s: Int) -> Stride { 0 }

            public static func seconds(_ s: Double) -> Stride { 0 }

            public static func milliseconds(_ ms: Int) -> Stride { 0 }

            public static func microseconds(_ us: Int) -> Stride { 0 }

            public static func nanoseconds(_ ns: Int) -> Stride { 0 }
        }
    }

    public typealias SchedulerOptions = Never

    /// The shared instance of the immediate scheduler.
    ///
    /// You cannot create instances of the immediate scheduler yourself. Use only the shared instance.
    public static let shared = ImmediateScheduler()

    @inlinable
    public func schedule(options: SchedulerOptions?, _ action: @escaping () -> Void) {
        action()
    }

    public var now: SchedulerTimeType { SchedulerTimeType() }

    public var minimumTolerance: SchedulerTimeType.Stride { 0 }

    public func schedule(after date: SchedulerTimeType,
                         tolerance: SchedulerTimeType.Stride,
                         options: SchedulerOptions?,
                         _ action: @escaping () -> Void) {
        fatalError(
            "Attempt to schedule something in the future on the immediate scheduler"
        )
    }

    /// Performs the action at some time after the specified date, at the specified
    /// frequency, optionally taking into account tolerance if possible.
    public func schedule(after date: SchedulerTimeType,
                         interval: SchedulerTimeType.Stride,
                         tolerance: SchedulerTimeType.Stride,
                         options: SchedulerOptions?,
                         _ action: @escaping () -> Void) -> Cancellable {
        fatalError(
            "Attempt to schedule something in the future on the immediate scheduler"
        )
    }
}
