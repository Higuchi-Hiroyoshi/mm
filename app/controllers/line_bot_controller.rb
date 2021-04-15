class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'].eql?('メニュー')
            client.reply_message(event['replyToken'], template1)
          elsif event.message['text'].eql?('Q1(目標設定)')
            client.reply_message(event['replyToken'], template2)
          elsif event.message['text'].eql?('Q2(問題認識)')
            client.reply_message(event['replyToken'], template3)
          elsif event.message['text'].eql?('Q3(現状分析)')
            client.reply_message(event['replyToken'], template4)
          elsif event.message['text'].eql?('Q4(計画策定)')
            client.reply_message(event['replyToken'], template5)
          elsif event.message['text'].eql?('Anser(実行→検証)')
            client.reply_message(event['replyToken'], template6)
          else
            client.reply_message(event['replyToken'], template1)
          end
        end
      end
    }
    head :ok
  end

  private
 
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def template1
    {
      "type": "flex",
      "altText": "メニュー",
      "contents": {
        "type": "carousel",
        "contents": [
          {
            "type": "bubble",
            "hero": {
              "type": "image",
              "url": "https://image.freepik.com/free-vector/brain-with-digital-circuit-and-programmer-with-laptop-machine-learning-artificial-intelligence-digital-brain-and-artificial-thinking-process-concept-vector-isolated-illustration_335657-2246.jpg",
              "size": "full",
              "aspectMode": "cover",
              "aspectRatio": "20:13"
            },
            "body": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "メニュー",
                  "size": "xl",
                  "weight": "bold"
                },
                {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                    {
                      "type": "box",
                      "layout": "baseline",
                      "contents": [
                        {
                          "type": "text",
                          "text": "『mm』をご利用いただき、誠にありがとうございます。\n\n下記からご選択ください。\n※新たな目標を立てる際は、\n『Q1(目標設定)』から順に行ってください。",
                          "flex": 5,
                          "size": "sm",
                          "color": "#666666",
                          "wrap": true
                        }
                      ],
                      "spacing": "sm"
                    }
                  ]
                }
              ],
              "action": {
                "type": "message",
                "label": "メニュー",
                "text": "メニュー"
              }
            },
            "footer": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "Q1(目標設定)",
                    "text": "Q1(目標設定)"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "Q2(問題認識)",
                    "text": "Q2(問題認識)"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "Q3(現状分析)",
                    "text": "Q3(現状分析)"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "Q4(計画策定)",
                    "text": "Q4(計画策定)"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "Anser(実行→検証)",
                    "text": "Anser(実行→検証)"
                  }
                },
                {
                  "type": "spacer"
                }
              ]
            }
          },
          {
            "type": "bubble",
            "hero": {
              "type": "image",
              "url": "https://image.freepik.com/free-vector/mobile-advertisement-and-digital-marketing-flat-design-marketing-research-color-illustration-woman-with-mobile-phone-mail-and-bullhorn-illustration-concept-isolated-on-white-background_174479-37.jpg",
              "size": "full",
              "aspectRatio": "20:13",
              "aspectMode": "cover"
            },
            "body": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "お問い合わせ",
                  "size": "xl",
                  "weight": "bold"
                },
                {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                    {
                      "type": "box",
                      "layout": "baseline",
                      "contents": [
                        {
                          "type": "text",
                          "text": "『mm』をご利用いただき、誠にありがとうございます。\n\nご意見・ご要望等は下記からご選択いただき、お問い合わせください。\n\nメールが送信されない場合は、お手数ですが、下記の『TEL』をご選択いただき、フリーダイヤルまでご連絡ください。\n\nｍｍ お客様相談室\n【受付時間】10：00～18：00\n（土・日・祝日は除く）\n\nお問い合わせの内容によっては、お時間を頂戴する場合がございます。",
                          "flex": 5,
                          "size": "sm",
                          "color": "#666666",
                          "wrap": true
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            "footer": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "button",
                  "action": {
                    "type": "uri",
                    "label": "MAIL",
                    "uri": "https://www.google.com/"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "uri",
                    "label": "TEL",
                    "uri": "https://line.me/R/call/81/09001234567"
                  }
                },
                {
                  "type": "spacer"
                }
              ]
            }
          },
          {
            "type": "bubble",
            "hero": {
              "type": "image",
              "url": "https://image.freepik.com/free-vector/modern-check-list-illustration_79603-146.jpg",
              "size": "full",
              "aspectRatio": "20:13",
              "aspectMode": "cover"
            },
            "body": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "アンケート",
                  "size": "xl",
                  "weight": "bold"
                },
                {
                  "type": "box",
                  "layout": "vertical",
                  "contents": []
                },
                {
                  "type": "box",
                  "layout": "baseline",
                  "contents": [
                    {
                      "type": "text",
                      "text": "『mm』をご利用いただき、誠にありがとうございます。\n\n下記をタップして、評価してください。",
                      "flex": 5,
                      "size": "sm",
                      "color": "#666666",
                      "wrap": true
                    }
                  ]
                }
              ]
            },
            "footer": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "👍",
                    "text": "👍"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "👎",
                    "text": "👎"
                  }
                },
                {
                  "type": "spacer"
                }
              ]
            }
          }
        ]
      }
    }
  end

  def template2
    {
      "type": "flex",
      "altText": "Q1(目標設定)",
      "contents": {
        "type": "bubble",
        "hero": {
          "type": "image",
          "url": "https://image.freepik.com/free-vector/workers-running-to-target-with-bar-chart-in-background_1262-19383.jpg",
          "size": "full",
          "aspectRatio": "20:13",
          "aspectMode": "cover",
          "action": {
            "type": "uri",
            "uri": "https://www.google.com/"
          }
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "Q1(目標設定)",
              "weight": "bold",
              "size": "xl"
            },
            {
              "type": "box",
              "layout": "vertical",
              "margin": "lg",
              "spacing": "sm",
              "contents": [
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "現在あなたが解決すべき目標を述べてください。",
                      "wrap": true,
                      "color": "#666666",
                      "size": "sm",
                      "flex": 5
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    }
  end

  def template3
    {
      "type": "flex",
      "altText": "Q2(問題認識)",
      "contents": {
        "type": "bubble",
        "hero": {
          "type": "image",
          "url": "https://image.freepik.com/free-vector/tiny-people-examining-operating-system-error-warning-on-web-page-isolated-flat-illustration_74855-11104.jpg",
          "size": "full",
          "aspectRatio": "20:13",
          "aspectMode": "cover",
          "action": {
            "type": "uri",
            "uri": "https://www.google.com/"
          }
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "Q2(問題認識)",
              "weight": "bold",
              "size": "xl"
            },
            {
              "type": "box",
              "layout": "vertical",
              "margin": "lg",
              "spacing": "sm",
              "contents": [
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "目標に対し、どういった障害が生じているかを述べてください。",
                      "wrap": true,
                      "color": "#666666",
                      "size": "sm",
                      "flex": 5
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    }
  end

  def template4
    {
      "type": "flex",
      "altText": "Q3(現状分析)",
      "contents": {
        "type": "bubble",
        "hero": {
          "type": "image",
          "url": "https://image.freepik.com/free-vector/analysis-concept-illustration_114360-1119.jpg",
          "size": "full",
          "aspectRatio": "20:13",
          "aspectMode": "cover",
          "action": {
            "type": "uri",
            "uri": "https://www.google.com/"
          }
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "Q3(現状分析)",
              "weight": "bold",
              "size": "xl"
            },
            {
              "type": "box",
              "layout": "vertical",
              "margin": "lg",
              "spacing": "sm",
              "contents": [
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "これからどのように取り組むかを述べてください。",
                      "wrap": true,
                      "color": "#666666",
                      "size": "sm",
                      "flex": 5
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    }
  end

  def template5
    {
      "type": "flex",
      "altText": "Q4(計画策定)",
      "contents": {
        "type": "bubble",
        "hero": {
          "type": "image",
          "url": "https://image.freepik.com/free-vector/people-starting-a-business-project_23-2148866842.jpg",
          "size": "full",
          "aspectRatio": "20:13",
          "aspectMode": "cover",
          "action": {
            "type": "uri",
            "uri": "https://www.google.com/"
          }
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "Q4(計画策定)",
              "weight": "bold",
              "size": "xl"
            },
            {
              "type": "box",
              "layout": "vertical",
              "margin": "lg",
              "spacing": "sm",
              "contents": [
                {
                  "type": "box",
                  "layout": "baseline",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "text",
                      "text": "最適な方法や案を述べてください。",
                      "wrap": true,
                      "color": "#666666",
                      "size": "sm",
                      "flex": 5
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    }
  end

  def template6
    {
      "type": "flex",
      "altText": "Anser(実行→検証)",
      "contents": {
        "type": "carousel",
        "contents": [
          {
            "type": "bubble",
            "hero": {
              "type": "image",
              "url": "https://image.freepik.com/free-vector/brain-with-digital-circuit-and-programmer-with-laptop-machine-learning-artificial-intelligence-digital-brain-and-artificial-thinking-process-concept-vector-isolated-illustration_335657-2246.jpg",
              "size": "full",
              "aspectMode": "cover",
              "aspectRatio": "20:13"
            },
            "body": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "Anser(実行→検証)",
                  "size": "xl",
                  "weight": "bold",
                  "action": {
                    "type": "message",
                    "label": "Anser(実行→検証)",
                    "text": "Anser(実行→検証)"
                  }
                },
                {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                    {
                      "type": "box",
                      "layout": "baseline",
                      "contents": [
                        {
                          "type": "text",
                          "text": "計画を実行に移し、環境変化や不安材料が生じれば、『Q2(問題認識)』に戻り、軌道修正を図っていきましょう。",
                          "flex": 5,
                          "size": "sm",
                          "color": "#666666",
                          "wrap": true,
                          "action": {
                            "type": "message",
                            "label": "Anser(実行→検証)",
                            "text": "Anser(実行→検証)"
                          }
                        }
                      ],
                      "spacing": "sm"
                    }
                  ]
                }
              ],
              "action": {
                "type": "message",
                "label": "Q2(問題認識)",
                "text": "Q2(問題認識)"
              }
            },
            "footer": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "Q2(問題認識)",
                    "text": "Q2(問題認識)"
                  }
                },
                {
                  "type": "spacer"
                }
              ],
              "action": {
                "type": "message",
                "label": "Q2(問題認識)",
                "text": "Q2(問題認識)"
              }
            }
          },
          {
            "type": "bubble",
            "hero": {
              "type": "image",
              "url": "https://image.freepik.com/free-vector/mobile-advertisement-and-digital-marketing-flat-design-marketing-research-color-illustration-woman-with-mobile-phone-mail-and-bullhorn-illustration-concept-isolated-on-white-background_174479-37.jpg",
              "size": "full",
              "aspectRatio": "20:13",
              "aspectMode": "cover"
            },
            "body": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "お問い合わせ",
                  "size": "xl",
                  "weight": "bold"
                },
                {
                  "type": "box",
                  "layout": "vertical",
                  "contents": [
                    {
                      "type": "box",
                      "layout": "baseline",
                      "contents": [
                        {
                          "type": "text",
                          "text": "『mm』をご利用いただき、誠にありがとうございます。\n\nご意見・ご要望等は下記からご選択いただき、お問い合わせください。\n\nメールが送信されない場合は、お手数ですが、下記の『TEL』をご選択いただき、フリーダイヤルまでご連絡ください。\n\nｍｍ お客様相談室\n【受付時間】10：00～18：00\n（土・日・祝日は除く）\n\nお問い合わせの内容によっては、お時間を頂戴する場合がございます。",
                          "flex": 5,
                          "size": "sm",
                          "color": "#666666",
                          "wrap": true
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            "footer": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "button",
                  "action": {
                    "type": "uri",
                    "label": "MAIL",
                    "uri": "https://www.google.com/"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "uri",
                    "label": "TEL",
                    "uri": "https://line.me/R/call/81/09001234567"
                  }
                },
                {
                  "type": "spacer"
                }
              ]
            }
          },
          {
            "type": "bubble",
            "hero": {
              "type": "image",
              "url": "https://image.freepik.com/free-vector/modern-check-list-illustration_79603-146.jpg",
              "size": "full",
              "aspectRatio": "20:13",
              "aspectMode": "cover"
            },
            "body": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "アンケート",
                  "size": "xl",
                  "weight": "bold"
                },
                {
                  "type": "box",
                  "layout": "vertical",
                  "contents": []
                },
                {
                  "type": "box",
                  "layout": "baseline",
                  "contents": [
                    {
                      "type": "text",
                      "text": "『mm』をご利用いただき、誠にありがとうございます。\n\n下記をタップして、評価してください。",
                      "flex": 5,
                      "size": "sm",
                      "color": "#666666",
                      "wrap": true
                    }
                  ]
                }
              ]
            },
            "footer": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "👍",
                    "text": "👍"
                  }
                },
                {
                  "type": "button",
                  "action": {
                    "type": "message",
                    "label": "👎",
                    "text": "👎"
                  }
                },
                {
                  "type": "spacer"
                }
              ]
            }
          }
        ]
      }
    }
  end
end
