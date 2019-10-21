include "console.iol"
include "string_utils.iol"


service HTTPStatus(){


	init {

		export StatusContinue           = 100, // RFC 7231, 6.2.1
		export StatusSwitchingProtocols = 101, // RFC 7231, 6.2.2
		export StatusProcessing         = 102, // RFC 2518, 10.1
		export StatusEarlyHints         = 103, // RFC 8297

		export StatusOK                   = 200, // RFC 7231, 6.3.1
		export StatusCreated              = 201, // RFC 7231, 6.3.2
		export StatusAccepted             = 202, // RFC 7231, 6.3.3
		export StatusNonAuthoritativeInfo = 203, // RFC 7231, 6.3.4
		export StatusNoContent            = 204, // RFC 7231, 6.3.5
		export StatusResetContent         = 205, // RFC 7231, 6.3.6
		export StatusPartialContent       = 206, // RFC 7233, 4.1
		export StatusMultiStatus          = 207, // RFC 4918, 11.1
		export StatusAlreadyReported      = 208, // RFC 5842, 7.1
		export StatusIMUsed               = 226, // RFC 3229, 10.4.1

		export StatusMultipleChoices   = 300, // RFC 7231, 6.4.1
		export StatusMovedPermanently  = 301, // RFC 7231, 6.4.2
		export StatusFound             = 302, // RFC 7231, 6.4.3
		export StatusSeeOther          = 303, // RFC 7231, 6.4.4
		export StatusNotModified       = 304, // RFC 7232, 4.1
		export StatusUseProxy          = 305, // RFC 7231, 6.4.5
		_                       = 306, // RFC 7231, 6.4.6 (Unused)
		export StatusTemporaryRedirect = 307, // RFC 7231, 6.4.7
		export StatusPermanentRedirect = 308, // RFC 7538, 3

		export StatusBadRequest                   = 400, // RFC 7231, 6.5.1
		export StatusUnauthorized                 = 401, // RFC 7235, 3.1
		export StatusPaymentRequired              = 402, // RFC 7231, 6.5.2
		export StatusForbidden                    = 403, // RFC 7231, 6.5.3
		export StatusNotFound                     = 404, // RFC 7231, 6.5.4
		export StatusMethodNotAllowed             = 405, // RFC 7231, 6.5.5
		export StatusNotAcceptable                = 406, // RFC 7231, 6.5.6
		export StatusProxyAuthRequired            = 407, // RFC 7235, 3.2
		export StatusRequestTimeout               = 408, // RFC 7231, 6.5.7
		export StatusConflict                     = 409, // RFC 7231, 6.5.8
		export StatusGone                         = 410, // RFC 7231, 6.5.9
		export StatusLengthRequired               = 411, // RFC 7231, 6.5.10
		export StatusPreconditionFailed           = 412, // RFC 7232, 4.2
		export StatusRequestEntityTooLarge        = 413, // RFC 7231, 6.5.11
		export StatusRequestURITooLong            = 414, // RFC 7231, 6.5.12
		export StatusUnsupportedMediaType         = 415, // RFC 7231, 6.5.13
		export StatusRequestedRangeNotSatisfiable = 416, // RFC 7233, 4.4
		export StatusExpectationFailed            = 417, // RFC 7231, 6.5.14
		export StatusTeapot                       = 418, // RFC 7168, 2.3.3
		export StatusMisdirectedRequest           = 421, // RFC 7540, 9.1.2
		export StatusUnprocessableEntity          = 422, // RFC 4918, 11.2
		export StatusLocked                       = 423, // RFC 4918, 11.3
		export StatusFailedDependency             = 424, // RFC 4918, 11.4
		export StatusTooEarly                     = 425, // RFC 8470, 5.2.
		export StatusUpgradeRequired              = 426, // RFC 7231, 6.5.15
		export StatusPreconditionRequired         = 428, // RFC 6585, 3
		export StatusTooManyRequests              = 429, // RFC 6585, 4
		export StatusRequestHeaderFieldsTooLarge  = 431, // RFC 6585, 5
		export StatusUnavailableForLegalReasons   = 451, // RFC 7725, 3

		export StatusInternalServerError           = 500, // RFC 7231, 6.6.1
		export StatusNotImplemented                = 501, // RFC 7231, 6.6.2
		export StatusBadGateway                    = 502, // RFC 7231, 6.6.3
		export StatusServiceUnavailable            = 503, // RFC 7231, 6.6.4
		export StatusGatewayTimeout                = 504, // RFC 7231, 6.6.5
		export StatusHTTPVersionNotSupported       = 505, // RFC 7231, 6.6.6
		export StatusVariantAlsoNegotiates         = 506, // RFC 2295, 8.1
		export StatusInsufficientStorage           = 507, // RFC 4918, 11.5
		export StatusLoopDetected                  = 508, // RFC 5842, 7.2
		export StatusNotExtended                   = 510, // RFC 2774, 7
		export StatusNetworkAuthenticationRequired = 511 // RFC 6585, 6

		status.(StatusContinue) =           "Continue"
		status.(StatusSwitchingProtocols) = "Switching Protocols"
		status.(StatusProcessing) =         "Processing"
		status.(StatusEarlyHints) =         "Early Hints"

		status.(StatusOK) =                   "OK"
		status.(StatusCreated) =              "Created"
		status.(StatusAccepted) =             "Accepted"
		status.(StatusNonAuthoritativeInfo) = "Non-Authoritative Information"
		status.(StatusNoContent) =            "No Content"
		status.(StatusResetContent) =         "Reset Content"
		status.(StatusPartialContent) =       "Partial Content"
		status.(StatusMultiStatus) =          "Multi-Status"
		status.(StatusAlreadyReported) =      "Already Reported"
		status.(StatusIMUsed) =               "IM Used"

		status.(StatusMultipleChoices) =   "Multiple Choices"
		status.(StatusMovedPermanently) =  "Moved Permanently"
		status.(StatusFound) =             "Found"
		status.(StatusSeeOther) =          "See Other"
		status.(StatusNotModified) =       "Not Modified"
		status.(StatusUseProxy) =          "Use Proxy"
		status.(StatusTemporaryRedirect) = "Temporary Redirect"
		status.(StatusPermanentRedirect) = "Permanent Redirect"

		status.(StatusBadRequest) =                   "Bad Request"
		status.(StatusUnauthorized) =                 "Unauthorized"
		status.(StatusPaymentRequired) =              "Payment Required"
		status.(StatusForbidden) =                    "Forbidden"
		status.(StatusNotFound) =                     "Not Found"
		status.(StatusMethodNotAllowed) =             "Method Not Allowed"
		status.(StatusNotAcceptable) =                "Not Acceptable"
		status.(StatusProxyAuthRequired) =            "Proxy Authentication Required"
		status.(StatusRequestTimeout) =               "Request Timeout"
		status.(StatusConflict) =                     "Conflict"
		status.(StatusGone) =                         "Gone"
		status.(StatusLengthRequired) =               "Length Required"
		status.(StatusPreconditionFailed) =           "Precondition Failed"
		status.(StatusRequestEntityTooLarge) =        "Request Entity Too Large"
		status.(StatusRequestURITooLong) =            "Request URI Too Long"
		status.(StatusUnsupportedMediaType) =         "Unsupported Media Type"
		status.(StatusRequestedRangeNotSatisfiable) = "Requested Range Not Satisfiable"
		status.(StatusExpectationFailed) =            "Expectation Failed"
		status.(StatusTeapot) =                       "I'm a teapot"
		status.(StatusMisdirectedRequest) =           "Misdirected Request"
		status.(StatusUnprocessableEntity) =          "Unprocessable Entity"
		status.(StatusLocked) =                       "Locked"
		status.(StatusFailedDependency) =             "Failed Dependency"
		status.(StatusTooEarly) =                     "Too Early"
		status.(StatusUpgradeRequired) =              "Upgrade Required"
		status.(StatusPreconditionRequired) =         "Precondition Required"
		status.(StatusTooManyRequests) =              "Too Many Requests"
		status.(StatusRequestHeaderFieldsTooLarge) =  "Request Header Fields Too Large"
		status.(StatusUnavailableForLegalReasons) =   "Unavailable For Legal Reasons"

		status.(StatusInternalServerError) =           "Internal Server Error"
		status.(StatusNotImplemented) =                "Not Implemented"
		status.(StatusBadGateway) =                    "Bad Gateway"
		status.(StatusServiceUnavailable) =            "Service Unavailable"
		status.(StatusGatewayTimeout) =                "Gateway Timeout"
		status.(StatusHTTPVersionNotSupported) =       "HTTP Version Not Supported"
		status.(StatusVariantAlsoNegotiates) =         "Variant Also Negotiates"
		status.(StatusInsufficientStorage) =           "Insufficient Storage"
		status.(StatusLoopDetected) =                  "Loop Detected"
		status.(StatusNotExtended) =                   "Not Extended"
		status.(StatusNetworkAuthenticationRequired) = "Network Authentication Required"
		;

		export status // how should we mark assessibility of variable 
	}

	//implementation of enumeration?

}