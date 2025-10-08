<?php
namespace App\Models;

// --- Laravel core ---
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Builder;

// --- Spatie ---
use Spatie\Permission\Traits\HasRoles;

// --- Relations ---
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

/**
 * App\Models\User
 *
 * @property int $id
 * @property string $name
 * @property string $email
 * @property \Illuminate\Support\Carbon|null $email_verified_at
 * @property string $password
 * @property string|null $remember_token
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property int|null $role_id
 * @property string|null $phone
 * @property string|null $avatar_path
 * @property int|null $dept_id
 * @property string|null $extension
 * @property bool $is_active
 * @property \Illuminate\Support\Carbon|null $last_login
 *
 * ==========================================
 * BUSINESS RELATIONS
 * ==========================================
 * @property-read \App\Models\Team|null $supervisedTeam
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\TeamMember[] $teamMemberships
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\Ticket[] $agentTickets
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\Ticket[] $supervisorTickets
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\TicketHistory[] $ticketHistories
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\TrackingEvent[] $trackingEvents
 *
 * ==========================================
 * AUDIT RELATIONS (created_by / updated_by)
 * ==========================================
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\Zone[] $createdZones
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\Zone[] $updatedZones
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\SubZone[] $createdSubZones
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\SubZone[] $updatedSubZones
 * ... (continue for all 25 tables)
 */
class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role_id',
        'phone',
        'avatar_path',
        'dept_id',
        'extension',
        'is_active',
        'last_login',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }



    /** Team that this user supervises (nullable). */
    public function supervisedTeam(): HasOne
    {
        return $this->hasOne(Team::class, 'supervisor_id');
    }

    public function scopeSupervisors(Builder $q): Builder
    {
        return $q->role('supervisor');      // Spatie helper
    }

  


    public function teamMemberships()
    {
        return $this->hasOne(TeamMember::class, 'user_id');
    }




    /** Teams this user is actually a member of (through pivot). */
    public function teams(): \Illuminate\Database\Eloquent\Relations\BelongsToMany
    {
        return $this->belongsToMany(Team::class, 'team_members', 'user_id', 'team_id')
            ->withPivot('is_leader')
            ->withTimestamps();
    }

    /** Tickets where user is the call-centre agent. */
    public function agentTickets(): HasMany
    {
        return $this->hasMany(Ticket::class, 'agent_id');
    }

    /** Tickets where user is the supervisor that dispatched the team. */
    public function supervisorTickets(): HasMany
    {
        return $this->hasMany(Ticket::class, 'supervisor_id');
    }

    /** All ticket history rows written by this user. */
    public function ticketHistories(): HasMany
    {
        return $this->hasMany(TicketHistory::class, 'user_id');
    }

    /** GPS / IP tracking events performed by this user. */
    public function trackingEvents(): HasMany
    {
        return $this->hasMany(TrackingEvent::class, 'user_id');
    }

    /* --------------------------------------------------------------------------
     * AUDIT RELATIONS  (created_by / updated_by)
     * -------------------------------------------------------------------------- */

    /* Generic helper to avoid writing 50 methods manually */
    private function auditRelation(string $model, string $field): HasMany
    {
        return $this->hasMany($model, $field);
    }

    public function createdZones(): HasMany
    {
        return $this->auditRelation(Zone::class, 'created_by');
    }
    public function updatedZones(): HasMany
    {
        return $this->auditRelation(Zone::class, 'updated_by');
    }
    public function createdSubZones(): HasMany
    {
        return $this->auditRelation(SubZone::class, 'created_by');
    }
    public function updatedSubZones(): HasMany
    {
        return $this->auditRelation(SubZone::class, 'updated_by');
    }

    public function createdTeams(): HasMany
    {
        return $this->auditRelation(Team::class, 'created_by');
    }
    public function updatedTeams(): HasMany
    {
        return $this->auditRelation(Team::class, 'updated_by');
    }
    public function createdTeamMembers(): HasMany
    {
        return $this->auditRelation(TeamMember::class, 'created_by');
    }
    public function updatedTeamMembers(): HasMany
    {
        return $this->auditRelation(TeamMember::class, 'updated_by');
    }
    public function createdCustomers(): HasMany
    {
        return $this->auditRelation(Customer::class, 'created_by');
    }
    public function updatedCustomers(): HasMany
    {
        return $this->auditRelation(Customer::class, 'updated_by');
    }
    public function createdAssetCategories(): HasMany
    {
        return $this->auditRelation(AssetCategory::class, 'created_by');
    }
    public function updatedAssetCategories(): HasMany
    {
        return $this->auditRelation(AssetCategory::class, 'updated_by');
    }
    public function createdAssets(): HasMany
    {
        return $this->auditRelation(Asset::class, 'created_by');
    }
    public function updatedAssets(): HasMany
    {
        return $this->auditRelation(Asset::class, 'updated_by');
    }
    public function createdStations(): HasMany
    {
        return $this->auditRelation(Station::class, 'created_by');
    }
    public function updatedStations(): HasMany
    {
        return $this->auditRelation(Station::class, 'updated_by');
    }
    public function createdSubStations(): HasMany
    {
        return $this->auditRelation(SubStation::class, 'created_by');
    }
    public function updatedSubStations(): HasMany
    {
        return $this->auditRelation(SubStation::class, 'updated_by');
    }
    public function createdMvLines(): HasMany
    {
        return $this->auditRelation(MvLine::class, 'created_by');
    }
    public function updatedMvLines(): HasMany
    {
        return $this->auditRelation(MvLine::class, 'updated_by');
    }
    public function createdTransformers(): HasMany
    {
        return $this->auditRelation(Transformer::class, 'created_by');
    }
    public function updatedTransformers(): HasMany
    {
        return $this->auditRelation(Transformer::class, 'updated_by');
    }
    public function createdDtLines(): HasMany
    {
        return $this->auditRelation(DtLine::class, 'created_by');
    }
    public function updatedDtLines(): HasMany
    {
        return $this->auditRelation(DtLine::class, 'updated_by');
    }
    public function createdServiceDrops(): HasMany
    {
        return $this->auditRelation(ServiceDrop::class, 'created_by');
    }
    public function updatedServiceDrops(): HasMany
    {
        return $this->auditRelation(ServiceDrop::class, 'updated_by');
    }
    public function createdMaintenanceTypes(): HasMany
    {
        return $this->auditRelation(MaintenanceType::class, 'created_by');
    }
    public function updatedMaintenanceTypes(): HasMany
    {
        return $this->auditRelation(MaintenanceType::class, 'updated_by');
    }
    public function createdMaintenanceTasks(): HasMany
    {
        return $this->auditRelation(MaintenanceTask::class, 'created_by');
    }
    public function updatedMaintenanceTasks(): HasMany
    {
        return $this->auditRelation(MaintenanceTask::class, 'updated_by');
    }
    public function createdSpareParts(): HasMany
    {
        return $this->auditRelation(SparePart::class, 'created_by');
    }
    public function updatedSpareParts(): HasMany
    {
        return $this->auditRelation(SparePart::class, 'updated_by');
    }
    public function createdTicketStatusTypes(): HasMany
    {
        return $this->auditRelation(TicketStatusType::class, 'created_by');
    }
    public function updatedTicketStatusTypes(): HasMany
    {
        return $this->auditRelation(TicketStatusType::class, 'updated_by');
    }
    public function createdTicketPriorities(): HasMany
    {
        return $this->auditRelation(TicketPriority::class, 'created_by');
    }
    public function updatedTicketPriorities(): HasMany
    {
        return $this->auditRelation(TicketPriority::class, 'updated_by');
    }
    public function createdTickets(): HasMany
    {
        return $this->auditRelation(Ticket::class, 'created_by');
    }
    public function updatedTickets(): HasMany
    {
        return $this->auditRelation(Ticket::class, 'updated_by');
    }
    public function createdEventTypes(): HasMany
    {
        return $this->auditRelation(EventType::class, 'created_by');
    }
    public function updatedEventTypes(): HasMany
    {
        return $this->auditRelation(EventType::class, 'updated_by');
    }



    public function getProfilePhotoUrlAttribute()
    {
        return $this->profile_photo
            ? asset('storage/' . $this->profile_photo)
            : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
    }

}
