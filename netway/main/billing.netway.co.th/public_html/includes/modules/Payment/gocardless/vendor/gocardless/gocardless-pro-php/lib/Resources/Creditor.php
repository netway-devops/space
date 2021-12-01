<?php
/**
 * WARNING: Do not edit by hand, this file was generated by Crank:
 *
 * https://github.com/gocardless/crank
 */

namespace GoCardlessPro\Resources;

/**
 * A thin wrapper around a creditor, providing access to it's
 * attributes
 *
 * @property-read $address_line1
 * @property-read $address_line2
 * @property-read $address_line3
 * @property-read $city
 * @property-read $country_code
 * @property-read $created_at
 * @property-read $id
 * @property-read $links
 * @property-read $logo_url
 * @property-read $name
 * @property-read $postal_code
 * @property-read $region
 * @property-read $scheme_identifiers
 * @property-read $verification_status
 */
class Creditor extends BaseResource
{
    protected $model_name = "Creditor";

    /**
     * The first line of the creditor's address.
     */
    protected $address_line1;

    /**
     * The second line of the creditor's address.
     */
    protected $address_line2;

    /**
     * The third line of the creditor's address.
     */
    protected $address_line3;

    /**
     * The city of the creditor's address.
     */
    protected $city;

    /**
     * [ISO
     * 3166-1](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)
     * alpha-2 code.
     */
    protected $country_code;

    /**
     * Fixed [timestamp](#api-usage-time-zones--dates), recording when this
     * resource was created.
     */
    protected $created_at;

    /**
     * Unique identifier, beginning with "CR".
     */
    protected $id;

    /**
     * 
     */
    protected $links;

    /**
     * URL for the creditor's logo, which may be shown on their payment pages.
     */
    protected $logo_url;

    /**
     * The creditor's name.
     */
    protected $name;

    /**
     * The creditor's postal code.
     */
    protected $postal_code;

    /**
     * The creditor's address region, county or department.
     */
    protected $region;

    /**
     * An array of the scheme identifiers this creditor can create mandates
     * against.
     * 
     * The support address, `phone_number` and `email` fields are for customers
     * to contact the merchant for support purposes. They must be displayed on
     * the payment page, please see our [compliance
     * requirements](#appendix-compliance-requirements) for more details.
     */
    protected $scheme_identifiers;

    /**
     * The creditor's verification status, indicating whether they can yet
     * receive payouts. For more details on handling verification as a partner,
     * see our ["Helping your users get verified"
     * guide](/getting-started/partners/helping-your-users-get-verified/). One
     * of:
     * <ul>
     * <li>`successful`: The creditor's account is fully verified, and they can
     * receive payouts. Once a creditor has been successfully verified, they may
     * in the future require further verification - for example, if they change
     * their payout bank account, we will have to check that they own the new
     * bank account before they can receive payouts again.</li>
     * <li>`in_review`: The creditor has provided all of the information
     * currently requested, and it is awaiting review by GoCardless before they
     * can be verified and receive payouts.</li>
     * <li>`action_required`: The creditor needs to provide further information
     * to verify their account so they can receive payouts, and should visit the
     * verification flow.</li>
     * </ul>
     */
    protected $verification_status;

}
