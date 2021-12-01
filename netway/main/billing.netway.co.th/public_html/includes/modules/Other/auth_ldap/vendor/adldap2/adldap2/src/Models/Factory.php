<?php

namespace Adldap\Models;

use Adldap\Contracts\Schemas\SchemaInterface;
use Adldap\Query\Builder;
use Adldap\Schemas\ActiveDirectory;

class Factory
{
    /**
     * @var Builder
     */
    protected $query;

    /**
     * @var SchemaInterface
     */
    protected $schema;

    /**
     * Constructor.
     *
     * @param Builder $builder
     */
    public function __construct(Builder $builder)
    {
        $this->setQuery($builder)
            ->setSchema($builder->getSchema());
    }

    /**
     * Sets the current query builder.
     *
     * @param Builder $builder
     *
     * @return Factory
     */
    public function setQuery(Builder $builder)
    {
        $this->query = $builder;

        return $this;
    }

    /**
     * Sets the current schema.
     *
     * @param SchemaInterface|null $schema
     *
     * @return Factory
     */
    public function setSchema(SchemaInterface $schema = null)
    {
        $this->schema = $schema ?: new ActiveDirectory();

        return $this;
    }

    /**
     * Creates a new user instance.
     *
     * @param array $attributes
     *
     * @return User
     */
    public function user(array $attributes = [])
    {
        return (new User($attributes, $this->query))
            ->setAttribute($this->schema->objectClass(), [
                $this->schema->top(),
                $this->schema->person(),
                $this->schema->organizationalPerson(),
                $this->schema->user(),
            ]);
    }

    /**
     * Creates a new organizational unit instance.
     *
     * @param array $attributes
     *
     * @return OrganizationalUnit
     */
    public function ou(array $attributes = [])
    {
        return (new OrganizationalUnit($attributes, $this->query))
            ->setAttribute($this->schema->objectClass(), [
                $this->schema->top(),
                $this->schema->organizationalUnit(),
            ]);
    }

    /**
     * Creates a new group instance.
     *
     * @param array $attributes
     *
     * @return Group
     */
    public function group(array $attributes = [])
    {
        return (new Group($attributes, $this->query))
            ->setAttribute($this->schema->objectClass(), [
                $this->schema->top(),
                $this->schema->objectCategoryGroup(),
            ]);
    }

    /**
     * Creates a new organizational unit instance.
     *
     * @param array $attributes
     *
     * @return Container
     */
    public function container(array $attributes = [])
    {
        return (new Container($attributes, $this->query))
            ->setAttribute($this->schema->objectClass(), $this->schema->organizationalUnit());
    }

    /**
     * Creates a new user instance as a contact.
     *
     * @param array $attributes
     *
     * @return User
     */
    public function contact(array $attributes = [])
    {
        return (new User($attributes, $this->query))
            ->setAttribute($this->schema->objectClass(), [
                $this->schema->top(),
                $this->schema->person(),
                $this->schema->organizationalPerson(),
                $this->schema->contact(),
            ]);
    }

    /**
     * Creates a new computer instance.
     *
     * @param array $attributes
     *
     * @return Computer
     */
    public function computer(array $attributes = [])
    {
        return (new Computer($attributes, $this->query))
            ->setAttribute($this->schema->objectClass(), [
                $this->schema->top(),
                $this->schema->person(),
                $this->schema->organizationalPerson(),
                $this->schema->user(),
                $this->schema->computer(),
            ]);
    }
}
