# BlockChyp Ruby SDK

[![Build Status](https://circleci.com/gh/blockchyp/blockchyp-ruby/tree/master.svg?style=shield)](https://circleci.com/gh/blockchyp/blockchyp-ruby/tree/master)
[![Gem](https://img.shields.io/gem/v/blockchyp)](https://rubygems.org/gems/blockchyp)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/blockchyp/blockchyp-ruby/blob/master/LICENSE)

This is the SDK for Ruby. Like all BlockChyp SDKs, it provides a full client
for the BlockChyp gateway and BlockChyp payment terminals.

## Installation

This SDK is best consumed as a Ruby Gem. Type the following command to install
the BlockChyp Gem in your project.

```
gem install blockchyp
```

## A Simple Example

Running your first transaction is easy. Make sure you have a BlockChyp terminal,
activate it, and generate a set of API keys. The sample code below show how
to run a basic terminal transaction.

```ruby
require 'blockchyp'

blockchyp = BlockChyp.new(
  "SPBXTSDAQVFFX5MGQMUMIRINVI",
  "7BXBTBUPSL3BP7I6Z2CFU6H3WQ",
  "bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e"
)

# Set request parameters
request = {
  "test": true,
  "terminalName": "Test Terminal",
  "amount": "55.00"
}

response = blockchyp.charge(request)

if (response["approved"])
  puts "Approved"
  puts "authCode:" + response["authCode"]
  puts "authorizedAmount:" + response["authorizedAmount"]
end
```



## The Rest APIs

All BlockChyp SDKs provide a convenient way of accessing the BlockChyp REST APIs.
You can checkout the REST API documentation via the links below.

[Terminal REST API Docs](https://docs.blockchyp.com/rest-api/terminal/index.html)

[Gateway REST API Docs](https://docs.blockchyp.com/rest-api/gateway/index.html)

## Other SDKs

BlockChyp has officially supported SDKs for eight different development platforms and counting.
Here's the full list with links to their GitHub repositories.

[Go SDK](https://github.com/blockchyp/blockchyp-go)

[Node.js/JavaScript SDK](https://github.com/blockchyp/blockchyp-js)

[Java SDK](https://github.com/blockchyp/blockchyp-java)

[.net/C# SDK](https://github.com/blockchyp/blockchyp-csharp)

[Ruby SDK](https://github.com/blockchyp/blockchyp-ruby)

[PHP SDK](https://github.com/blockchyp/blockchyp-php)

[Python SDK](https://github.com/blockchyp/blockchyp-python)

[iOS (Objective-C/Swift) SDK](https://github.com/blockchyp/blockchyp-ios)

## Getting a Developer Kit

In order to test your integration with real terminals, you'll need a BlockChyp
Developer Kit. Our kits include a fully functioning payment terminal with
test pin encryption keys. Every kit includes a comprehensive set of test
cards with test cards for every major card brand and entry method, including
Contactless and Contact EMV and mag stripe cards. Each kit also includes
test gift cards for our blockchain gift card system.

Access to BlockChyp's developer program is currently invite only, but you
can request an invitation by contacting our engineering team at **nerds@blockchyp.com**.

You can also view a number of long form demos and learn more about us on our [YouTube Channel](https://www.youtube.com/channel/UCE-iIVlJic_XArs_U65ZcJg).

## Transaction Code Examples

You don't want to read words. You want examples. Here's a quick rundown of the
stuff you can do with the BlockChyp Ruby SDK and a few basic examples.

#### Charge

Executes a standard direct preauth and capture.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "amount": '55.00'
}

response = blockchyp.charge(request)

puts "Response: #{response.inspect}"


```

#### Preauthorization

Executes a preauthorization intended to be captured later.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "amount": '27.00'
}

response = blockchyp.preauth(request)

puts "Response: #{response.inspect}"


```

#### Terminal Ping

Tests connectivity with a payment terminal.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "terminalName": 'Test Terminal'
}

response = blockchyp.ping(request)

puts "Response: #{response.inspect}"


```

#### Balance

Checks the remaining balance on a payment method.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "cardType": CardType::EBT
}

response = blockchyp.balance(request)

puts "Response: #{response.inspect}"


```

#### Terminal Clear

Clears the line item display and any in progress transaction.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal'
}

response = blockchyp.clear(request)

puts "Response: #{response.inspect}"


```

#### Terms & Conditions Capture

Prompts the user to accept terms and conditions.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',

  # Alias for a Terms and Conditions template configured in the BlockChyp
  # dashboard.
  "tcAlias": 'hippa',

  # Name of the contract or document if not using an alias.
  "tcName": 'HIPPA Disclosure',

  # Full text of the contract or disclosure if not using an alias.
  "tcContent": 'Full contract text',

  # File format for the signature image.
  "sigFormat": SignatureFormat::PNG,

  # Width of the signature image in pixels.
  "sigWidth": 200,

  # Whether or not a signature is required. Defaults to true.
  "sigRequired": true
}

response = blockchyp.termsAndConditions(request)

puts "Response: #{response.inspect}"


```

#### Update Transaction Display

Appends items to an existing transaction display.  Subtotal, Tax, and Total are
overwritten by the request. Items with the same description are combined into
groups.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "transaction": {
    "subtotal": '60.00',
    "tax": '5.00',
    "total": '65.00',
    "items": [
      {
        "description": 'Leki Trekking Poles',
        "price": '35.00',
        "quantity": 2,
        "extended": '70.00',
        "discounts": [
          {
            "description": 'memberDiscount',
            "amount": '10.00'
          }
        ]
      }
    ]
  }
}

response = blockchyp.updateTransactionDisplay(request)

puts "Response: #{response.inspect}"


```

#### New Transaction Display

Displays a new transaction on the terminal.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "transaction": {
    "subtotal": '60.00',
    "tax": '5.00',
    "total": '65.00',
    "items": [
      {
        "description": 'Leki Trekking Poles',
        "price": '35.00',
        "quantity": 2,
        "extended": '70.00',
        "discounts": [
          {
            "description": 'memberDiscount',
            "amount": '10.00'
          }
        ]
      }
    ]
  }
}

response = blockchyp.newTransactionDisplay(request)

puts "Response: #{response.inspect}"


```

#### Text Prompt

Asks the consumer a text based question.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',

  # Type of prompt. Can be 'email', 'phone', 'customer-number', or
  # 'rewards-number'.
  "promptType": PromptType::EMAIL
}

response = blockchyp.textPrompt(request)

puts "Response: #{response.inspect}"


```

#### Boolean Prompt

Asks the consumer a yes/no question.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "prompt": 'Would you like to become a member?',
  "yesCaption": 'Yes',
  "noCaption": 'No'
}

response = blockchyp.booleanPrompt(request)

puts "Response: #{response.inspect}"


```

#### Display Message

Displays a short message on the terminal.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "message": 'Thank you for your business.'
}

response = blockchyp.message(request)

puts "Response: #{response.inspect}"


```

#### Refund

Executes a refund.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "terminalName": 'Test Terminal',
  "transactionId": '<PREVIOUS TRANSACTION ID>',

  # Optional amount for partial refunds.
  "amount": '5.00'
}

response = blockchyp.refund(request)

puts "Response: #{response.inspect}"


```

#### Enroll

Adds a new payment method to the token vault.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal'
}

response = blockchyp.enroll(request)

puts "Response: #{response.inspect}"


```

#### Gift Card Activation

Activates or recharges a gift card.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "terminalName": 'Test Terminal',
  "amount": '50.00'
}

response = blockchyp.giftActivate(request)

puts "Response: #{response.inspect}"


```

#### Time Out Reversal

Executes a manual time out reversal.

We love time out reversals. Don't be afraid to use them whenever a request to a
BlockChyp terminal times out. You have up to two minutes to reverse any
transaction. The only caveat is that you must assign transactionRef values when
you build the original request. Otherwise, we have no real way of knowing which
transaction you're trying to reverse because we may not have assigned it an id
yet. And if we did assign it an id, you wouldn't know what it is because your
request to the terminal timed out before you got a response.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "terminalName": 'Test Terminal',
  "transactionRef": '<LAST TRANSACTION REF>'
}

response = blockchyp.reverse(request)

puts "Response: #{response.inspect}"


```

#### Capture Preauthorization

Captures a preauthorization.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "transactionId": '<PREAUTH TRANSACTION ID>'
}

response = blockchyp.capture(request)

puts "Response: #{response.inspect}"


```

#### Close Batch

Closes the current credit card batch.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true
}

response = blockchyp.closeBatch(request)

puts "Response: #{response.inspect}"


```

#### Void Transaction

Discards a previous preauth transaction.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "test": true,
  "transactionId": '<PREVIOUS TRANSACTION ID>'
}

response = blockchyp.void(request)

puts "Response: #{response.inspect}"


```

#### Terminal Status

Returns the current status of a terminal.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "terminalName": 'Test Terminal'
}

response = blockchyp.terminalStatus(request)

puts "Response: #{response.inspect}"


```

#### Capture Signature.

Captures and returns a signature.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "terminalName": 'Test Terminal',

  # File format for the signature image.
  "sigFormat": SignatureFormat::PNG,

  # Width of the signature image in pixels.
  "sigWidth": 200
}

response = blockchyp.captureSignature(request)

puts "Response: #{response.inspect}"


```

#### Update Customer

Updates or creates a customer record.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "customer": {
    "id": 'ID of the customer to update',
    "customerRef": 'Customer reference string',
    "firstName": 'FirstName',
    "lastName": 'LastName',
    "companyName": 'Company Name',
    "emailAddress": 'support@blockchyp.com',
    "smsNumber": '(123) 123-1231'
  }
}

response = blockchyp.updateCustomer(request)

puts "Response: #{response.inspect}"


```

#### Retrieve Customer

Retrieves a customer by id.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "customerId": 'ID of the customer to retrieve'
}

response = blockchyp.customer(request)

puts "Response: #{response.inspect}"


```

#### Search Customer

Searches the customer database.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "query": '(123) 123-1234'
}

response = blockchyp.customerSearch(request)

puts "Response: #{response.inspect}"


```

#### Cash Discount

Calculates the discount for actual cash transactions.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "amount": '100.00'
}

response = blockchyp.cashDiscount(request)

puts "Response: #{response.inspect}"


```

#### Transaction Status

Retrieves the current status of a transaction.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "transactionId": 'ID of transaction to retrieve'
}

response = blockchyp.transactionStatus(request)

puts "Response: #{response.inspect}"


```

#### Send Payment Link

Creates and send a payment link to a customer.


```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp::BlockChyp.new(
  ENV['BC_API_KEY'],
  ENV['BC_BEARER_TOKEN'],
  ENV['BC_SIGNING_KEY']
)

# Set request parameters
request = {
  "amount": '199.99',
  "description": 'Widget',
  "subject": 'Widget invoice',
  "transaction": {
    "subtotal": '195.00',
    "tax": '4.99',
    "total": '199.99',
    "items": [
      {
        "description": 'Widget',
        "price": '195.00',
        "quantity": 1
      }
    ]
  },
  "autoSend": true,
  "customer": {
    "customerRef": 'Customer reference string',
    "firstName": 'FirstName',
    "lastName": 'LastName',
    "companyName": 'Company Name',
    "emailAddress": 'support@blockchyp.com',
    "smsNumber": '(123) 123-1231'
  }
}

response = blockchyp.sendPaymentLink(request)

puts "Response: #{response.inspect}"


```

## Running Integration Tests

If you'd like to run the integration tests, create a new file on your system
called `sdk-itest-config.json` with the API credentials you'll be using as
shown in the example below.

```
{
 "gatewayHost": "https://api.blockchyp.com",
 "testGatewayHost": "https://test.blockchyp.com",
 "apiKey": "PZZNEFK7HFULCB3HTLA7HRQDJU",
 "bearerToken": "QUJCHIKNXOMSPGQ4QLT2UJX5DI",
 "signingKey": "f88a72d8bc0965f193abc7006bbffa240663c10e4d1dc3ba2f81e0ca10d359f5"
}
```

This file can be located in a few different places, but is usually located
at `<USER_HOME>/.config/blockchyp/sdk-itest-config.json`. All BlockChyp SDKs
use the same configuration file.

To run the integration test suite via `make`, type the following command:

`make integration`


## Running Integration Tests Via Rake or Ruby

If you'd like to bypass make and run the integration test suite directly,
you can run the entire test suite with Rake using the following command:

`BC_TEST_DELAY=5 rake test`

You can run individual tests by adding executing them as normal Ruby files.

`ruby test/terminal_charge_test.rb`





## Contributions

BlockChyp welcomes contributions from the open source community, but bear in mind
that this repository has been generated by our internal SDK Generator tool. If
we choose to accept a PR or contribution, your code will be moved into our SDK
Generator project, which is a private repository.

## License

Copyright BlockChyp, Inc., 2019

Distributed under the terms of the [MIT] license, blockchyp-ruby is free and open source software.

[MIT]: https://github.com/blockchyp/blockchyp-ruby/blob/master/LICENSE
