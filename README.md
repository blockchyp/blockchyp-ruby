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

blockchyp = BlockChyp.new("SPBXTSDAQVFFX5MGQMUMIRINVI", "7BXBTBUPSL3BP7I6Z2CFU6H3WQ", "bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e")

# setup request object
request = Hash.new
request["test"] = true
request["terminalName"] = "Test Terminal"
request["amount"] = "55.00"

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

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['amount'] = '55.00'

response = blockchyp.charge(request)

if response['approved']
  puts 'Approved'
end

puts 'authCode:' + response['authCode']
puts 'authorizedAmount:' + response['authorizedAmount']


```

#### Preauthorization

Executes a preauthorization intended to be captured later.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['amount'] = '27.00'

response = blockchyp.preauth(request)

if response['approved']
  puts 'Approved'
end

puts 'authCode:' + response['authCode']
puts 'authorizedAmount:' + response['authorizedAmount']


```

#### Terminal Ping

Tests connectivity with a payment terminal.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['terminalName'] = 'Test Terminal'

response = blockchyp.ping(request)

if response['success']
  puts 'Success'
end



```

#### Balance

Checks the remaining balance on a payment method.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['cardType'] = CardType::EBT

response = blockchyp.balance(request)

if response['success']
  puts 'Success'
end



```

#### Terminal Clear

Clears the line item display and any in progress transaction.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'

response = blockchyp.clear(request)

if response['success']
  puts 'Success'
end



```

#### Terms & Conditions Capture

Prompts the user to accept terms and conditions.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['tcAlias'] = 'hippa'
request['tcName'] = 'HIPPA Disclosure'
request['tcContent'] = 'Full contract text'
request['sigFormat'] = SignatureFormat::PNG
request['sigWidth'] = 200
request['sigRequired'] = true

response = blockchyp.termsAndConditions(request)

if response['success']
  puts 'Success'
end

puts 'sig:' + response['sig']
puts 'sigFile:' + response['sigFile']


```

#### Update Transaction Display

Appends items to an existing transaction display Subtotal, Tax, and Total are
overwritten by the request. Items with the same description are combined into
groups.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['transaction'] = new_transaction_display_transaction

response = blockchyp.updateTransactionDisplay(request)

if response['success']
  puts 'Success'
end

def new_transaction_display_transaction
  val = {}
  val['subtotal'] = '60.00'
  val['tax'] = '5.00'
  val['total'] = '65.00'
  val['items'] = new_transaction_display_items
  val
end

def new_transaction_display_items
  val = []
  val = val.push(new_transaction_display_item_2)
  val
end

def new_transaction_display_item_2
  val = {}
  val['description'] = 'Leki Trekking Poles'
  val['price'] = '35.00'
  val['quantity'] = 2
  val['extended'] = '70.00'
  val['discounts'] = new_transaction_display_discounts
  val
end

def new_transaction_display_discounts
  val = []
  val = val.push(new_transaction_display_discount_2)
  val
end

def new_transaction_display_discount_2
  val = {}
  val['description'] = 'memberDiscount'
  val['amount'] = '10.00'
  val
end




```

#### New Transaction Display

Displays a new transaction on the terminal.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['transaction'] = new_transaction_display_transaction

response = blockchyp.newTransactionDisplay(request)

if response['success']
  puts 'Success'
end

def new_transaction_display_transaction
  val = {}
  val['subtotal'] = '60.00'
  val['tax'] = '5.00'
  val['total'] = '65.00'
  val['items'] = new_transaction_display_items
  val
end

def new_transaction_display_items
  val = []
  val = val.push(new_transaction_display_item_2)
  val
end

def new_transaction_display_item_2
  val = {}
  val['description'] = 'Leki Trekking Poles'
  val['price'] = '35.00'
  val['quantity'] = 2
  val['extended'] = '70.00'
  val['discounts'] = new_transaction_display_discounts
  val
end

def new_transaction_display_discounts
  val = []
  val = val.push(new_transaction_display_discount_2)
  val
end

def new_transaction_display_discount_2
  val = {}
  val['description'] = 'memberDiscount'
  val['amount'] = '10.00'
  val
end




```

#### Text Prompt

Asks the consumer text based question.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['promptType'] = PromptType::EMAIL

response = blockchyp.textPrompt(request)

if response['success']
  puts 'Success'
end

puts 'response:' + response['response']


```

#### Boolean Prompt

Asks the consumer a yes/no question.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['prompt'] = 'Would you like to become a member?'
request['yesCaption'] = 'Yes'
request['noCaption'] = 'No'

response = blockchyp.booleanPrompt(request)

if response['success']
  puts 'Success'
end

puts 'response:' + response['response']


```

#### Display Message

Displays a short message on the terminal.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['message'] = 'Thank you for your business.'

response = blockchyp.message(request)

if response['success']
  puts 'Success'
end



```

#### Refund

Executes a refund.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['terminalName'] = 'Test Terminal'
request['transactionId'] = '<PREVIOUS TRANSACTION ID>'
request['amount'] = '5.00'

response = blockchyp.refund(request)

if response['approved']
  puts 'Approved'
end



```

#### Enroll

Adds a new payment method to the token vault.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'

response = blockchyp.enroll(request)

if response['approved']
  puts 'Approved'
end

puts 'token:' + response['token']


```

#### Gift Card Activation

Activates or recharges a gift card.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['terminalName'] = 'Test Terminal'
request['amount'] = '50.00'

response = blockchyp.giftActivate(request)

if response['approved']
  puts 'Approved'
end

puts 'amount:' + response['amount']
puts 'currentBalance:' + response['currentBalance']
puts 'publicKey:' + response['publicKey']


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

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['terminalName'] = 'Test Terminal'
request['transactionRef'] = '<LAST TRANSACTION REF>'

response = blockchyp.reverse(request)

if response['approved']
  puts 'Approved'
end



```

#### Capture Preauthorization

Captures a preauthorization.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['transactionId'] = '<PREAUTH TRANSACTION ID>'

response = blockchyp.capture(request)

if response['approved']
  puts 'Approved'
end



```

#### Close Batch

Closes the current credit card batch.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true

response = blockchyp.closeBatch(request)

if response['success']
  puts 'Success'
end

puts 'capturedTotal:' + response['capturedTotal']
puts 'openPreauths:' + response['openPreauths']


```

#### Void Transaction

Discards a previous preauth transaction.

```ruby
# frozen_string_literal: true

require 'blockchyp'

blockchyp = BlockChyp.new(
  'SPBXTSDAQVFFX5MGQMUMIRINVI',
  '7BXBTBUPSL3BP7I6Z2CFU6H3WQ',
  'bcae3708938cb8004ab1278e6c0fcd68f9d815e1c3c86228d028242b147af58e'
)

# setup request object
request = {}
request['test'] = true
request['transactionId'] = '<PREVIOUS TRANSACTION ID>'

response = blockchyp.void(request)

if response['approved']
  puts 'Approved'
end



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
