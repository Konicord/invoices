defmodule Billing do
  alias Billing.Invoice
  alias Billing.Invoice.{Company, Article, Total, PaymentInformation}

  def list_invoices do
    now = DateTime.utc_now()
    %{year: year} = now
    in_30_days = DateTime.add(now, 24 * 3600 * 30, :second)

    [
      # Detailed example
      %Invoice{
        id: 1,
        title: "Monthly Invoice",
        seller: phoenix_company(),
        client: elixir_company(),
        issued_on: now,
        payment_due_date: in_30_days,
        number: "#{year}-1",
        articles: [
          %Article{
            details: "Development Days",
            qty: Enum.random(1..10),
            unit_price: Enum.random(150..790),
            vat: 20,
            total_excl_vat: 4000,
            total: 4800
          }
        ],
        total: %Total{
          total_excl_vat: 4000,
          vat_amount: 800,
          total: 4800
        },
        payment_information: payment_information()
      },

      # Basic example
      %Invoice{
        id: 2,
        title: "Monthly Invoice",
        seller: phoenix_company(),
        client: elixir_company(),
        issued_on: now,
        payment_due_date: in_30_days,
        number: "#{year}-2",
        articles:
          Enum.map(~w(Name1 Name2 Name4 Name4), fn developer ->
            %Article{
              details: "Development days for #{developer}",
              qty: Enum.random(1..10),
              unit_price: Enum.random(150..790),
              vat: 20,
              total_excl_vat: 4000,
              total: 4800
            }
          end),
        total: %Total{
          total_excl_vat: 4000 * 4,
          vat_amount: 800 * 4,
          total: 4800 * 4
        },
        payment_information: payment_information()
      }
    ]
  end

  def get_invoice(id) do
    Enum.find(list_invoices(), &(&1.id == id))
  end

  defp phoenix_company do
    %Company{
      name: "From [NAME]",
      logo: "/logo.png",
      address: "Kossuth L. u. 1–3",
      zip_code: "9700",
      city: "Szombathely",
      country: "Hungary",
      registration_number: "00001/2012-023-01",
      vat_number: "HU 11310918218"
    }
  end

  defp elixir_company do
    %Company{
      name: "TO [NAME]",
      logo: nil,
      address: "Kossuth L. u. 1–3",
      zip_code: "9700",
      city: "Szombathely",
      country: "Hungary",
      registration_number: "00002/2012-023-2",
      vat_number: "HU 22421029329"
    }
  end

  defp payment_information do
    %PaymentInformation{
      bic: "KSS84565FD",
      iban: "HU55 34905837374534577",
      reference: "992304785"
    }
  end
end
